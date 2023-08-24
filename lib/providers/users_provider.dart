import 'package:inventory_plus/global_h.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static final Users _instance = Users._internal();
  factory Users() => _instance;
  Users._internal() {}

  FetchState _fetchState = FetchState.init;
  String message = '';
  User _user = User();

  FetchState get status => _fetchState;
  User get user {
    if (_fetchState == FetchState.init) {
      if (providerDummyDataMode) {
        _user = dummyUser;
        _fetchState = FetchState.success;
      } else {
        this._fetchUser();
      }
    }
    return _user;
  }

  Future<void> _fetchUser() async {
    try {
      _fetchState = FetchState.loading;
      final response = await http.get(
        Uri.parse('${Api.url}/users'),
        headers: Api.headers,
      );

      message = response.statusCode.toString();
      if (response.statusCode == 200) {
        _fetchState = FetchState.success;
        _user = User.fromJson(json.decode(response.body));
      }
    } catch (e) {
      _fetchState = FetchState.error;
      message = '$e';
    }
    print(message);
    notifyListeners();
  }
}
