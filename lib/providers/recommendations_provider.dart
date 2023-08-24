import 'package:inventory_plus/global_h.dart';
import 'package:http/http.dart' as http;

class Recommendations with ChangeNotifier {
  static final Recommendations _instance = Recommendations._internal();
  factory Recommendations() => _instance;
  Recommendations._internal() {}

  FetchState _fetchState = FetchState.init;
  String message = '';
  List<ItemRecommendation> _recommendedItems = [];

  FetchState get status => _fetchState;
  List<ItemRecommendation> get items => _recommendedItems;

  Future<void> fetchRecommendedItems(String upc) async {
    if (upc.isWhitespace()) {
      return;
    }

    try {
      _fetchState = FetchState.loading;
      final response = await http.get(
        Uri.parse(
            '${Api.affiliateUrl}/recommendations?keywords=$upc&affiliates=ebay&max=10'),
        headers: Api.headers,
      );

      message = response.statusCode.toString();
      if (response.statusCode == 200) {
        _fetchState = FetchState.success;
        _recommendedItems = json
            .decode(response.body)
            .map((item) => ItemRecommendation.fromJson(item))
            .toList();
      }
    } catch (e) {
      _fetchState = FetchState.error;
      message = '$e';
    }
    notifyListeners();
  }
}
