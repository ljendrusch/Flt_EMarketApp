import 'package:inventory_plus/global_h.dart';
import 'package:http/http.dart' as http;

class Items with ChangeNotifier {
  static final Items _instance = Items._internal();
  factory Items() => _instance;
  Items._internal() {}

  FetchState _fetchState = FetchState.init;
  String message = '';
  List<Item> _items = [];
  // List<BarcodeRecommendation> _recommendations = [];

  FetchState get status => _fetchState;
  List<Item> get items {
    if (_fetchState == FetchState.init) {
      if (providerDummyDataMode) {
        _items = dummyItems;
        _fetchState = FetchState.success;
      } else {
        this._fetchItems();
      }
    }
    return _items;
  }
  // List<BarcodeRecommendation> get recommendations => _recommendations;

  bool isEmpty() => size() == 0;
  int size() => _items.length;

  Future<void> _fetchItems() async {
    try {
      _fetchState = FetchState.loading;
      final response = await http.get(
        Uri.parse('${Api.url}/items'),
        headers: Api.headers,
      );

      message = response.statusCode.toString();
      if (response.statusCode == 200) {
        _fetchState = FetchState.success;
        var data = response.body;
        var dynamics = json.decode(data) as List<dynamic>;
        _items = dynamics
            .map((item) => Item.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      _fetchState = FetchState.error;
      message = '$e';
    }
    print(message);
    notifyListeners();
  }

  // Function to get the recent items of user.
  List<Item> getRecentItems() {
    _items.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return (_items.length > 10) ? _items.sublist(0, 10) : _items;
  }

  List<Item> findPublicItems() =>
      _items.where((item) => item.isPublic).toList();

  Future<BarcodeScanResult?> getBarcodeRecommendation(String upc) async {
    try {
      if (upc != '') {
        final response = await http.get(
          Uri.parse('${Api.url}/upc/$upc'),
          headers: Api.headers,
        );

        if (response.statusCode == 200) {
          final String data = response.body;
          final item = json.decode(data) as Map<String, dynamic>;

          final BarcodeScanResult recommendedItemObj =
              BarcodeScanResult.fromJson(item);
          return recommendedItemObj;
        }
      }
    } catch (e) {
      message = '$e';
    }
    return null;
  }

  Future<Item?> fetchItem(String id) async {
    if (id.isWhitespace()) return null;
    try {
      final response = await http.get(
        Uri.parse('${Api.url}/items/$id'),
        headers: Api.headers,
      );

      if (response.statusCode == 200) {
        final String data = response.body;
        final item = json.decode(data) as Map<String, dynamic>;
        final Item itemObj = Item.fromJson(item);
        return itemObj;
      }
    } catch (e) {
      message = '$e';
    }
    return null;
  }

  // Add Item to the list.
  Future<Item?> addItem(Item item) async {
    // if upc is provided manually, we update upc
    for (final Field field in item.fields) {
      if (field.type == FieldType.text &&
          (field.name.toLowerCase() == 'upc' ||
              field.name.toLowerCase() == 'barcode')) {
        item.upc = field.value;
      }
    }

    // copy all the images and upload later
    // final List<ImageItem> imageUrls = [];
    final List<ImageItem> imageFiles = [];

    // append the image urls back to the item
    // for (final ImageItem image in item.images) {
    //   if (image.type == ImageType.url) {
    //     imageUrls.add(image);
    //   } else if (image.type == ImageType.file) {
    //     imageFiles.add(image);
    //   }
    // }

    // item.images = imageUrls;

    // Add a new item without images
    try {
      final String json = itemToJson(item);
      final response = await http.post(
        Uri.parse('${Api.url}/items'),
        headers: Api.headers,
        body: json,
      );

      if (response.statusCode == 201) {
        // item has been created, we get its id
        final String id = response.body;

        // upload images for the item id
        final bool uploaded = await _uploadImages(id, imageFiles);

        // append the uploaded urls to the item
        if (uploaded) {
          final Item? newItem = await fetchItem(id);

          if (newItem != null) {
            item.images = newItem.images;
          }
        }

        // upload images for this item id
        item.id = id;
        // insert it to the memory
        _items.insert(0, item);
        notifyListeners();

        return item;
      }
    } catch (e) {
      message = '$e';
    }
    return null;
  }

  // Edit/Update an item in the list.
  Future<Item?> updateItem(Item item) async {
    // PUT API
    final String id = item.id;

    // if item id not existed, we add new item instead
    if (id.isWhitespace()) {
      return addItem(item);
    }

    _fetchState = FetchState.init;

    // if upc is provided manually, we update upc
    for (final Field field in item.fields) {
      if (field.type == FieldType.text &&
          (field.name.toLowerCase() == 'upc' ||
              field.name.toLowerCase() == 'barcode')) {
        item.upc = field.value;
      }
    }

    // copy all the images and upload later
    final List<ImageItem> imageUrls = [];
    final List<ImageItem> imageFiles = [];

    // append the image urls back to the item
    for (final ImageItem image in item.images) {
      if (image.type == ImageType.url) {
        imageUrls.add(image);
      } else if (image.type == ImageType.file) {
        imageFiles.add(image);
      }
    }

    item.images = imageUrls;

    try {
      _fetchState = FetchState.loading;
      final response = await http.put(Uri.parse('${Api.url}/items/$id'),
          // Send authorization headers to the backend.
          headers: Api.headers,
          body: itemToJson(item));

      if (response.statusCode == 200) {
        _fetchState = FetchState.success;
        // upload images for the item id
        final bool uploaded = await _uploadImages(id, imageFiles);

        // append the uploaded urls to the item
        if (uploaded) {
          final Item? newItem = await fetchItem(id);

          if (newItem != null) {
            item.images = newItem.images;
          }
        }
        // replace the item in the memory
        final int index = _items.indexWhere((item) => item.id == id);
        _items[index] = item;
        notifyListeners();
        return item;
      }
    } catch (e) {
      _fetchState = FetchState.error;
      message = '$e';
    }
    notifyListeners();
    return null;
  }

  // Delete an Item from the list.
  Future<bool> removeItem(String? id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Api.url}/items/$id'),
        // Send authorization headers to the backend.
        headers: Api.headers,
      );

      if (response.statusCode == 200) {
        _items.removeWhere((item) => item.id == id);

        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  // Function to pin an item.
  Future<bool> pinItem(Item item) async {
    item.isPublic = true;
    await updateItem(item);
    return _fetchState == FetchState.success;
  }

  // Function to unpin an item.
  Future<bool> unpinItem(Item item) async {
    item.isPublic = false;
    await updateItem(item);
    return _fetchState == FetchState.success;
  }

  // Function to upload an item images.
  Future<bool> _uploadImages(String id, List<ImageItem> images) async {
    // if (id.isWhitespace()) {
    //   return false;
    // }

    // bool uploaded = false;
    // final String url = '${Api.url}/items/$id/image';

    // // iterate all images and update any files
    // for (int i = 0; i < images.length; i++) {
    //   final bool response = await _uploadImage(images[i], url);

    //   if (response) {
    //     uploaded = true;
    //   }
    // }

    // return uploaded;
    return false;
  }

  // Function to send the uploaded images as multipart request.
  // Future<bool> _uploadImage(ImageItem image, String url) async {
  // only upload file
  // if (image.type != ImageType.file) {
  //   return false;
  // }

  // // open a byteStream
  // final File imageFile = File(image.value);
  // final http.ByteStream stream = http.ByteStream(imageFile.openRead())
  //   ..cast();
  // // get file length
  // final int length = await imageFile.length();
  // // create multipart request
  // final http.MultipartRequest request =
  //     http.MultipartRequest('POST', Uri.parse(url));
  // // multipart that takes file.. here this "image_file" is a key of the API request
  // final http.MultipartFile multipartFile = http.MultipartFile(
  //     'image', stream, length,
  //     filename: basename(imageFile.path));

  // // add authorization
  // request.headers['Authorization'] = Api.basicAuth;
  // // add file to multipart
  // request.files.add(multipartFile);

  // // send request to upload image
  // final response = await request.send();

  // if (response.statusCode == 200) {
  //   return true;
  // }

  //   return false;
  // }
}
