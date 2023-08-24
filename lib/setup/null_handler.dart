import 'package:inventory_plus/global_h.dart';

dynamic handleNull(DataType type, dynamic json) {
  if (json == null) {
    if (type == DataType.number) {
      return 0;
    } else if (type == DataType.decimal) {
      return 0.0;
    } else if (type == DataType.bool) {
      return true;
    } else if (type == DataType.string) {
      return '';
    } else if (type == DataType.date) {
      return DateTime.now().toString();
    } else if (type == DataType.list) {
      return [];
    }
  }

  return json as dynamic;
}
