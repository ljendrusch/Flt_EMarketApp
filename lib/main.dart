import 'package:inventory_plus/global_h.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('localSettings');
  _backendConnectionTest();
  runApp(const InventoryApp());
}

Future<void> _backendConnectionTest() async {
  http.Response? response;
  try {
    final response = await http.get(
      Uri.parse('${Api.url}/items'),
      headers: Api.headers,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final String data = response.body;
      print(data);
    }
  } catch (e) {
    print(e);
    print(response?.statusCode);
  }
}
