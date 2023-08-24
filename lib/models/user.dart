import 'package:inventory_plus/global_h.dart';

User userFromJson(String data) => User.fromJson(json.decode(data));
String userToJson(User data) => json.encode(data.toJson());

/// User class for a user profile biograph
class User {
  String id;
  String name;
  ImageItem imageItem;
  String email;
  String description;
  String location;
  double totalValue;
  int itemsCount;
  int tagsCount;
  List<Item> recentItems;
  List<Item> recommendedItems;

  User({
    this.id = '',
    this.name = '',
    this.imageItem = const ImageItem(
        type: ImageType.url,
        value: 'https://randomuser.me/api/portraits/men/67.jpg'),
    this.email = '',
    this.description = '',
    this.location = '',
    this.totalValue = 0,
    this.itemsCount = 0,
    this.tagsCount = 0,
    List<Item>? recentItems,
    List<Item>? recommendedItems,
  })  : recentItems = recentItems ?? [],
        recommendedItems = recommendedItems ?? [];

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: handleNull(DataType.string, json['userId']) as String,
        name: handleNull(DataType.string, json['name']) as String,
        // ImageItem.fromJson(json['image']),
        email: handleNull(DataType.date, json['email']) as String,
        description: handleNull(DataType.string, json['description']) as String,
        location: handleNull(DataType.string, json['location']) as String,
        totalValue: handleNull(DataType.decimal, json['totalValue']) as double,
        itemsCount: handleNull(DataType.number, json['itemsCount']) as int,
        tagsCount: handleNull(DataType.number, json['tagsCount']) as int,
        recentItems:
            (handleNull(DataType.list, json['recentItems']) as List<dynamic>)
                .map((item) => Item.fromJson(item as Map<String, dynamic>))
                .toList(),
        // recommendedItems: (handleNull(DataType.list, json['fields']) as List<dynamic>)
        //     .map((field) => Field.fromJson(field as Map<String, dynamic>))
        //     .toList(),
      );

  Map<String, dynamic> toJson() => {
        if (id != '') 'userId': id,
        'name': name,
        // 'image': image.value,
        'email': email,
        'description': description,
        'location': location,
      };

  ImageProvider get imageProvider => NetworkImage(this.imageItem.value);
  Image get image => Image(image: this.imageProvider);
  DecorationImage decorationImage({BoxFit boxfit = BoxFit.cover}) =>
      DecorationImage(fit: boxfit, image: this.imageProvider);
}
