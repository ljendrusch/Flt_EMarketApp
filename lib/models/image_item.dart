import 'package:inventory_plus/global_h.dart';

ImageItem imageFromJson(String data) =>
    ImageItem(type: ImageType.url, value: '');
// ImageItem imageFromJson(String data) =>
//     ImageItem.fromJson(json.decode(data) as Map<String, dynamic>);
String imageToJson(ImageItem imageItem) =>
    ImageItem(type: ImageType.url, value: '').toJson();
// String imageToJson(ImageItem imageItem) => imageItem.toJson();

class ImageItem {
  final ImageType type;
  final String value;

  const ImageItem({
    required this.type,
    required this.value,
  });

  factory ImageItem.fromJson(dynamic json) =>
      ImageItem(type: ImageType.url, value: '');

  // factory ImageItem.fromJson(dynamic json) =>
  // ImageItem(
  //       type: ImageType.url,
  //       value: handleNull(DataType.string, json) as String,
  //     );

  String toJson() => value;

  // Image toWidget() => (type == ImageType.asset)
  //     ? Image.asset(value)
  //     : (type == ImageType.url)
  //         ? Image.network(value)
  //         : (type == ImageType.file)
  //             ? Image.file(File(value))
  //             : Image.asset('assets/logo.png');
}
