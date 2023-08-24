import 'package:inventory_plus/global_h.dart';

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWrapper(child: App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = Provider.of<LocalSettings>(context).themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory +',
      theme: flexThemeLight,
      darkTheme: flexThemeDark,
      themeMode: themeMode,
      initialRoute: splashRoute,
      onGenerateRoute: router,
    );
  }
}

// class Loading extends StatelessWidget {
//   const Loading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Inventory +',
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: const Color(0xff0f151d),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
