import 'package:inventory_plus/global_h.dart';

class Api {
  static const String url = 'http://localhost:8080';
  static const String affiliateUrl =
      'http://inventory-affiliate-tf-1578610671.us-west-2.elb.amazonaws.com';

  static Map<String, String> get headers => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth,
      };

  static const String _dummyUserId = '623555fd6232ed614bf6e640';
  static const String _dummyUserPw = 'test_password';

  static String get basicAuth =>
      'Basic ${base64Encode(utf8.encode('$_dummyUserId:$_dummyUserPw'))}';
}
