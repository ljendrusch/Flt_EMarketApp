import 'package:inventory_plus/global_h.dart';
import 'package:http/http.dart' as http;

class Tags with ChangeNotifier {
  static final Tags _instance = Tags._internal();
  factory Tags() => _instance;
  Tags._internal() {}

  FetchState _fetchState = FetchState.init;
  String message = '';
  List<Tag> _tags = [];

  FetchState get status => _fetchState;
  List<Tag> get tags {
    if (_fetchState == FetchState.init) {
      if (providerDummyDataMode) {
        _tags = dummyTagsWithImages;
        _fetchState = FetchState.success;
      } else {
        this._fetchTags();
      }
    }
    return _tags;
  }

  bool isEmpty() => size() == 0;
  int size() => _tags.length;

  Future<void> _fetchTags() async {
    try {
      _fetchState = FetchState.loading;
      final response = await http.get(
        Uri.parse('${Api.url}/tags'),
        headers: Api.headers,
      );

      message = response.statusCode.toString();
      if (response.statusCode == 200) {
        _fetchState = FetchState.success;
        var data = response.body;
        var dynamics = json.decode(data) as List<dynamic>;
        _tags = dynamics
            .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      _fetchState = FetchState.error;
      message = '$e';
    }
    print(message);
    notifyListeners();
  }

  Future<Tag?> fetchTag(String id) async {
    try {
      _fetchState = FetchState.loading;
      final response = await http.get(
        Uri.parse('${Api.url}/tags/$id'),
        headers: Api.headers,
      );

      if (response.statusCode == 200) {
        _fetchState = FetchState.success;
        final String data = response.body;
        final tag = json.decode(data) as Map<String, dynamic>;
        final Tag tagObj = Tag.fromJson(tag);
        return tagObj;
      }
    } catch (e) {
      _fetchState = FetchState.error;
      message = '$e';
      return null;
    }
    return null;
  }

  Tag findById(String id) =>
      _tags.firstWhere((tag) => tag.id == id, orElse: () => Tag());

  Future<bool> addTag(Tag tag) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.url}/tags'),
        headers: Api.headers,
        body: tagToJson(tag),
      );

      // if tag added successfully, then add it to the memory.
      if (response.statusCode == 201) {
        final Tag newTag =
            Tag.fromJson(json.decode(response.body) as Map<String, dynamic>);

        tag.id = newTag.id;
        _tags.insert(0, tag);
        notifyListeners();
        return true;
      }
    } catch (e) {
      message = '$e';
    }
    return false;
  }

  Future<bool> updateTag(Tag tag) async {
    if (tag.name.isWhitespace()) {
      return false;
    }
    if (!_tags.any((e) => e.name == tag.name)) {
      return addTag(tag);
    }

    try {
      final response = await http.put(Uri.parse('${Api.url}/tags/${tag.id}'),
          // Send authorization headers to the backend.
          headers: Api.headers,
          body: tagToJson(tag));

      // if update success, update the tag in the memory
      if (response.statusCode == 200) {
        final Tag newTag =
            Tag.fromJson(json.decode(response.body) as Map<String, dynamic>);

        _tags[_tags.indexWhere((element) => element.id == newTag.id)] = newTag;

        notifyListeners();
        return true;
      }
    } catch (e) {
      message = '$e';
    }
    return false;
  }

  Future<bool> removeTag(Tag tag) async {
    if (tag.id == null) {
      return false;
    }
    try {
      final String? id = tag.id;
      final response = await http.delete(
        Uri.parse('${Api.url}/tags/$id'),
        // Send authorization headers to the backend.
        headers: Api.headers,
      );

      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      }
    } catch (e) {
      message = '$e';
    }
    return false;
  }
}
