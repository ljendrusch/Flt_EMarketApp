import 'package:inventory_plus/global_h.dart';

User dummyUser = User(
  id: dummyUserId,
  name: 'Cameron Johnson',
  imageItem: ImageItem(type: ImageType.url, value: dummyUserImageUrls[0]),
  email: 'cameron.johnson@example.com',
  location: 'San Francisco, CA',
  itemsCount: 2,
  tagsCount: 12,
  totalValue: 599,
);

List<User> dummyUsers = [
  dummyUser,
  User(
    name: 'Lillian Lopez',
    imageItem: ImageItem(type: ImageType.url, value: dummyUserImageUrls[1]),
    email: 'lillian.lopez@example.com',
    location: '6515 Saddle Dr',
  ),
];

const String dummyUserId = '626872f01fd25a169de7c61e';

List<Item> dummyItems = [
  Item(
    userId: dummyUserId,
    name: 'Womens Air Jordan 1 Low SE Limelight Shoes',
    tags: [Tag(id: '0', name: 'Shoes')],
    createdDate: DateTime.parse('2022-02-03 20:00:00Z').toString(),
    upc: '9771234567003',
    images: [ImageItem(type: ImageType.url, value: dummyItemImageUrls[2])],
    value: 100,
    isPublic: true,
  ),
  Item(
    userId: dummyUserId,
    name: "Air Jordan 1 Retro High OG 'University Blue' Shoes",
    tags: [Tag(id: '0', name: 'Shoes')],
    createdDate: DateTime.parse('2022-02-04 20:00:00Z').toString(),
    upc: '9780123456786',
    images: [ImageItem(type: ImageType.url, value: dummyItemImageUrls[0])],
    value: 499,
    isPublic: true,
  ),
];

List<Tag> dummyTags = List<Tag>.generate(
    24, (index) => Tag(id: '${index + 1}', name: 'Shoes ${index + 1}'));
List<Tag> dummyTagsWithImages = List<Tag>.generate(
    24,
    (index) => Tag(
        id: '${index + 1}',
        name: 'Shoes ${index + 1}',
        imageItem: ImageItem(type: ImageType.url, value: '')));

List<Map<String, dynamic>> dummyItemsJson = [
  {
    'userId': dummyUserId,
    'name': 'Womens Air Jordan 1 Low SE Limelight Shoes',
    'createdDate': DateTime.parse('2022-02-03 20:00:00Z').toString(),
    'price': 100,
    'ownedDate': DateTime.parse('2022-02-20 20:00:00Z').toString(),
    'images': [dummyItemImageUrls[0]],
    'upc': '9771234567003',
  },
  {
    'userId': dummyUserId,
    'name': "Air Jordan 1 Retro High OG 'University Blue' Shoes",
    'createdDate': DateTime.parse('2022-02-20 20:00:00Z').toString(),
    'price': 499,
    'ownedDate': DateTime.parse('2022-02-20 20:00:00Z').toString(),
    'images': [dummyItemImageUrls[1]],
    'upc': '9780123456786',
  }
];
