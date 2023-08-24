import 'package:inventory_plus/global_h.dart';

class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Users()),
        ChangeNotifierProvider(create: (context) => Items()),
        ChangeNotifierProvider(create: (context) => Tags()),
        ChangeNotifierProvider(create: (context) => Recommendations()),
        ChangeNotifierProvider(create: (context) => LocalSettings()),
      ],
      child: child,
    );
  }
}
