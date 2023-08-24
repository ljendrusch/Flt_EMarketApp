import 'package:inventory_plus/global_h.dart';

BarcodeScanResult barcodeItemFromJson(String data) =>
    BarcodeScanResult.fromJson(json.decode(data) as Map<String, dynamic>);
String barcodeItemToJson(BarcodeScanResult data) => json.encode(data.toJson());

class BarcodeScanResult {
  String barcode;
  String name;
  List<ImageItem> images;
  double value;

  BarcodeScanResult({
    this.barcode = '',
    this.name = '',
    this.images = const [],
    this.value = 0.0,
  });

  factory BarcodeScanResult.fromJson(Map<String, dynamic> json) =>
      BarcodeScanResult(
        name: handleNull(DataType.string, json['name']) as String,
        barcode: handleNull(DataType.string, json['upc']) as String,
        value: handleNull(DataType.decimal, json['value']) as double,
        images: (handleNull(DataType.list, json['images']) as List<dynamic>)
            .map((image) => ImageItem.fromJson(image as String))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'upc': barcode,
        'value': value,
        'images': List<dynamic>.from(images.map((image) => imageToJson(image))),
      };
}
