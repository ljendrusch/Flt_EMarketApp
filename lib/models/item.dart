import 'package:inventory_plus/global_h.dart';

Item itemFromJson(String data) =>
    Item.fromJson(json.decode(data) as Map<String, dynamic>);
String itemToJson(Item data) => json.encode(data.toJson());

/// Item class for a single item
class Item {
  // All final fields are required
  // Fields with ? is optional
  String id;
  String userId;
  String name;
  List<Tag> tags;
  String createdDate;
  String upc;
  double value;
  String description;
  List<ImageItem> images;
  List<Field> fields;
  bool isPublic;

  Item({
    this.id = '',
    this.userId = '',
    this.name = '',
    List<Tag>? tags,
    this.createdDate = '',
    this.upc = '',
    this.isPublic = false,
    this.value = 0.0,
    this.description = '',
    List<ImageItem>? images,
    List<Field>? fields,
  })  : tags = tags ?? [],
        images = images ?? [],
        fields = fields ?? [];

  factory Item.fromJson(Map<String, dynamic> json) {
    String name = handleNull(DataType.string, json['name']) as String;
    return Item(
      id: handleNull(DataType.string, json['itemId']) as String,
      userId: handleNull(DataType.string, json['userId']) as String,
      name: name,
      isPublic: handleNull(DataType.bool, json['isPublic']) as bool,
      createdDate: handleNull(DataType.date, json['createdDate']) as String,
      tags: (handleNull(DataType.list, json['tags']) as List<dynamic>)
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toList(),
      upc: handleNull(DataType.string, json['upc']) as String,
      value: handleNull(DataType.decimal, json['value']) as double,
      description: handleNull(DataType.string, json['description']) as String,
      images: [
        ImageItem(type: ImageType.url, value: dummyItemImageUrlPicker(name))
      ],
      // images: (handleNull(DataType.list, json['images']) as List<dynamic>)
      //     .map((image) => ImageItem.fromJson(image as String))
      //     .toList(),
      fields: (handleNull(DataType.list, json['fields']) as List<dynamic>)
          .map((field) => Field.fromJson(field as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != '') 'itemId': id,
        'name': name,
        if (userId != '') 'userId': userId,
        'createdDate': createdDate,
        'tags': List<dynamic>.from(tags.map((tag) => tagToJson(tag))),
        'upc': upc,
        'isPublic': isPublic,
        'value': value,
        'description': description,
        // 'images': List<dynamic>.from(images.map((image) => imageToJson(image))),
        'fields': List<dynamic>.from(fields.map((field) => fieldToJson(field))),
      };

  ImageProvider get imageProvider => NetworkImage(this.images[0].value);
  Image get image => Image(image: this.imageProvider);
  DecorationImage decorationImage({BoxFit boxfit = BoxFit.cover}) =>
      DecorationImage(fit: boxfit, image: this.imageProvider);
}
