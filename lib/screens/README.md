## Screens Class Files

- [error_screen.dart] Screen that simply shows routing error text in the center and a back button at the top-left. Only reachable by code that tries to open a non-existing screen name.
- [home_scaffold.dart] Not a full screen but the frame of the Home, Inventory, and Search screens. Defines the bottom navigation bar (the four buttons at the base of the main screens), the app bar (the top of the screen that shows the main screen page title and scanner and add buttons), and the settings drawer (the settings list that slides from the right when the user presses the cog button at the bottom-right).
- [home.dart] The first tab of home_scaffold. The first screen a logged-in user will see. Displays brief information about a selection of the user's collection.
- [inventory.dart] The second tab of home_scaffold. Displays 1) a user's Items as item_tiles or item_boxes, or 2) a user's Tags as tag_tiles or tag_boxes.
- [item_details.dart] Screen that displays a specific Item's information in detail. Routed to by clicking an item_tile or item_box from anywhere in the app.
- [item_form.dart] Screen that handles adding Items to a user's collection. Contains multiple form fields that accept and validate user input (makes sure there's a name entered, etc.), and displays a 'Save' button that, when pressed, makes an Item object and posts it to the database. Routed to by pressing the + button in the appBar of a home_scaffold screen and selecting 'Add an Item'.
- [login.dart] Login screen. Shows the logo, a text field for proprietary accounts (not implemented), and buttons to initiate oauth through facebook (implementation under way), twitter (not implementated), or google (implementation under way). 
- [profile.dart] Screen that displays detailed information from the User object, i.e. the user's profile. Routed to by clicking on the user information section of the endDrawer.
- [scan_handler.dart] Screen that parses the result from a barcode scan and lets a user add an Item based off of it to their inventory. Routed to by scanning a barcode with the code_scanner, which is activated by pressing the scan button in the appBar of a home_scaffold screen.
- [screens_h.dart] Header/barrel file.
- [search.dart] The third tab of home_scaffold. Items from the user's collection are displayed as item_tiles based on text input typed into the TextFormField at the top of the page.
- [splash.dart] Splash screen that fades the logo in and out over three seconds then routes to login.
- [tag_details.dart] Screen that displays a specific Tag's information in detail. Routed to by clicking a tag_tile or tag_box from anywhere in the app.
- [tag_form.dart] Screen that handles adding Tags to a user's collection. Contains multiple form fields that accept and validate user input (makes sure there's a name entered, etc.), and displays a 'Save' button that, when pressed, makes a Tag object and posts it to the database. Routed to by pressing the + button in the appBar of a home_scaffold screen and selecting 'Make a Tag'.
