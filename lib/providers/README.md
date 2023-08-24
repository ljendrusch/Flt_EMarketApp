## Providers Class Files

- [items_provider.dart] Overhead data cloud of Item objects. Fetches data from the database over the internet. Implements all CRUD operations for managing Item data in the app and said database. Whenever notifyListeners() is called from this object all widgets that access its data will be rebuilt.
- [local_settings_provider.dart] Overhead data cloud of persistent local app settings, such as light/dark mode choice. Fetches data from local files on the device when first instantiated. Updates data throughout the app and in the local files whenever the respective settings are changed.
- [providers_h.dart] Header/barrel file. Also contains a const global bool variable that enables or disables using hard-coded dummy data instead of getting data from the database, for debugging use.
- [recommendations_provider.dart] Overhead data cloud of ItemRecommendation objects. Fetches data from an affiliate URL over the internet when called. Affiliate integration is not fully implemented.
- [tags_provider.dart] Overhead data cloud of Tag objects. Fetches data from the database over the internet. Implements all CRUD operations for managing Tag data in the app and said database. Whenever notifyListeners() is called from this object all widgets that access its data will be rebuilt.
- [users_provider.dart] Overhead data cloud for the User object. Fetches data from the database over the internet. Any changes to relational data, such as the User's itemsCount going up when a new Item is added, is done automatically in the database.
