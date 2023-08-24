import 'package:inventory_plus/global_h.dart';

Tag tagFromJson(String data) => Tag.fromJson(json.decode(data));
String tagToJson(Tag data) => json.encode(data.toJson());

class Tag {
  String? id;
  String name;
  String description;
  ImageItem? imageItem;
  String qrcode;
  List<Item> items;

  Tag({
    this.id,
    this.name = '',
    this.description = '',
    this.imageItem,
    this.qrcode = '',
    this.items = const [],
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    String name = handleNull(DataType.string, json['name']) as String;
    return Tag(
      id: handleNull(DataType.string, json['tagId']) as String,
      name: name,
      description: handleNull(DataType.string, json['description']) as String,
      imageItem: ImageItem(
          type: ImageType.url,
          value: dummyTagImageUrlPicker(
              name)), // ImageItem.fromJson(json['image']),
      items: (handleNull(DataType.list, json['items']) as List<dynamic>)
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'tagId': id,
        'name': name,
        'description': description,
        // if (image != null) 'image': image!.value,
        'qrcode': qrcode,
        'items': List<dynamic>.from(items.map((item) => itemToJson(item))),
      };

  ImageProvider get imageProvider => NetworkImage(this.imageItem!.value);
  Image get image => Image(image: this.imageProvider);
  DecorationImage decorationImage({BoxFit boxfit = BoxFit.cover}) =>
      DecorationImage(fit: boxfit, image: this.imageProvider);
}
