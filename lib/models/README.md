## Models Class Files

- [barcode_scan_result.dart] Data type definition for a barcode's id, name, value, any associated images, and functions to generate json data from an instance or instantiate an instance from json data. Used in the code_scanner button and scan_handler screen.
- [field.dart] Helper data type to facilitate custom member usage in user objects.
- [image_item.dart] Helper data type to facilitate making UI elements out of image data, as image data parsing differs depending on its source; Is it from the internet? Is it a file in the project directory? Is it data in memory? ImageItems should come from the database, but image, i.e. "blob" data storage isn't working properly. Instead, they're being created with hard-coded default url image data.
- [item_recommendation.dart] Data type definition for pertinent information of a recommended purchase from an affiliate service, like Ebay. Such functionality is not yet implemented. Used in the item_details screen.
- [item.dart] Data type definition for an Item and functions to generate json data from an instance or instantiate an instance from json data. Items are the focus of this app and are used in every screen. Items are owned by a User and may be connected to any number of Tags. Items may have image data, custom fields, upc's, and may be flagged as public or private.
- [models_h.dart] Header/barrel file.
- [tag.dart] Data type definition for a Tag and functions to generate json data from an instance or instantiate an instance from json data. Tags are tied closely with Items and are used indirectly in most screens, but are most visible in the inventory, tag_details, and tag_form screens. Tags may link to any number of Items, and Items may be connected to any number of Tags.
- [user.dart] Data type definition for a User and functions to generate json data from an instance or instantiate an instance from json data. Most visible in the endDrawer of the home_scaffold and the profile screen.
