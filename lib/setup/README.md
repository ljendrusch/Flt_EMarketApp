## Setup Class Files

- [api_info.dart] Static definition of http request addresses and header data including basic auth.
- [dummy_defs.dart] Fake data to give to providers instead of having them get data from the internet, should the fake data be enabled. For debugging purposes only.
- [dummy_image_urls.dart] Fake image urls to bind to Item, Tag, or User objects. Currently the database isn't working properly transmitting image, i.e. "blob," data so these urls are a workaround.
- [extensions.dart] In Dart/Flutter, an "extension" is an addendum to an already fully-defined data type. Here we 1) extend the String data type to include functions to check if parsing a string will yield a certain data type, and 2) add helper functions on a data type that explains the state of a UI element: Is it being pressed? Is it disabled? Is it actively accepting input? etc.
- [flex_themes.dart] Definitions of theme data for the app using the flex_color_scheme package and google_fonts. There are two sets of theme data, _light and _dark, that define unique color schemes and default visual settings for most common Material/Flutter UI elements, such as an ElevatedButton or a NavigationBar.
- [null_handler.dart] Helper function to ensure there are no null fields in json data.
- [provider_wrapper.dart] Instantiates the providers, i.e. overhead data clouds.
- [router.dart] Defines specifically how to switch to each screen.
- [setup_h.dart] Header/barrel file.
- [type_enums.dart] Enums used to constrain 1) data communication between entities such as screens and 2) mode options for certain UI elements.
