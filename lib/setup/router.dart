import 'package:inventory_plus/global_h.dart';

Route<dynamic> router(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (_) => const Splash());
    case loginRoute: // '/login'
      return MaterialPageRoute(builder: (_) => const Login());
    case homeRoute: // '/'
      return MaterialPageRoute(builder: (_) => const HomeScaffold(args: 0));
    case inventoryRoute: // '/'
      return MaterialPageRoute(builder: (_) => const HomeScaffold(args: 1));
    case searchRoute: // '/'
      return MaterialPageRoute(builder: (_) => const HomeScaffold(args: 2));
    case profileRoute: // '/profile'
      return MaterialPageRoute(builder: (_) => const Profile());
    case itemDetailRoute: // '/itemDetails'
      return MaterialPageRoute(
          builder: (_) => ItemDetails(item: settings.arguments as Item));
    case tagDetailRoute: // '/tagDetails'
      return MaterialPageRoute(
          builder: (_) => TagDetails(tag: settings.arguments as Tag));
    case itemFormRoute: // '/itemForm'
      return MaterialPageRoute(
          builder: (_) => ItemForm(item: settings.arguments as Item?));
    case tagFormRoute: // '/tagForm'
      return MaterialPageRoute(
          builder: (_) => TagForm(args: settings.arguments));
    case scanHandlerRoute:
      return MaterialPageRoute(
          builder: (_) => ScanHandler(args: settings.arguments as String));
    default:
      return MaterialPageRoute(
          builder: (_) => ErrorPage(errorString: settings.name ?? '[unknown]'));
  }
}
