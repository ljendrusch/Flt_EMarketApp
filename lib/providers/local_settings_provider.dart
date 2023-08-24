import 'package:inventory_plus/global_h.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalSettings with ChangeNotifier {
  static final LocalSettings _instance = LocalSettings._internal();
  factory LocalSettings() => _instance;
  LocalSettings._internal() {
    _themeMode = (_box.get('themeIsDarkMode', defaultValue: false))
        ? ThemeMode.dark
        : ThemeMode.light;
    _itemsViewType = (_box.get('itemsViewIsGrid', defaultValue: false))
        ? ViewMode.grid
        : ViewMode.list;
    _tagsViewType = (_box.get('tagsViewIsGrid', defaultValue: true))
        ? ViewMode.grid
        : ViewMode.list;
  }

  final Box _box = Hive.box('localSettings');

  late ThemeMode _themeMode;
  late ViewMode _itemsViewType;
  late ViewMode _tagsViewType;

  ThemeMode get themeMode => _themeMode;
  ViewMode get itemsViewType => _itemsViewType;
  ViewMode get tagsViewType => _tagsViewType;

  void setThemeMode(ThemeMode t) {
    _themeMode = t;
    _box.put('themeIsDarkMode', (t == ThemeMode.dark));
    notifyListeners();
  }

  void setItemsViewType(ViewMode t) {
    _itemsViewType = t;
    _box.put('itemsViewIsGrid', (t == ViewMode.grid));
    notifyListeners();
  }

  void setTagsViewType(ViewMode t) {
    _tagsViewType = t;
    _box.put('tagsViewIsGrid', (t == ViewMode.grid));
    notifyListeners();
  }
}
