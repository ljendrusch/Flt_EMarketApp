import 'package:inventory_plus/global_h.dart';

ItemRecommendation itemRecommendationFromJson(String data) =>
    ItemRecommendation.fromJson(json.decode(data) as Map<String, dynamic>);

class ItemRecommendation {
  String affiliateItemId;
  String name;
  ImageItem imageItem;
  String value;
  String affiliateLink;

  ItemRecommendation({
    this.affiliateItemId = '',
    this.name = '',
    this.imageItem = const ImageItem(type: ImageType.url, value: ''),
    this.value = '',
    this.affiliateLink = '',
  });

  factory ItemRecommendation.fromJson(Map<String, dynamic> json) =>
      ItemRecommendation(
          affiliateItemId:
              handleNull(DataType.string, json['itemId']) as String,
          name: handleNull(DataType.string, json['title']) as String,
          value: handleNull(DataType.decimal, json['convertedCurrentPrice'])
              as String,
          imageItem: ImageItem.fromJson(json['galleryURL'] as String),
          affiliateLink:
              handleNull(DataType.string, json['affiliateLink']) as String);

  static int _imageCount = 0;
  ImageProvider get imageProvider => NetworkImage(
      dummyRecItemImageUrls[_imageCount++ % dummyRecItemImageUrls.length]);
  Image get image => Image(image: this.imageProvider);
  DecorationImage decorationImage({BoxFit boxfit = BoxFit.cover}) =>
      DecorationImage(fit: boxfit, image: this.imageProvider);
}
