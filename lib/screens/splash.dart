import 'package:inventory_plus/global_h.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      // animationDuration: Duration(seconds: 3),
      splash: Image.asset('assets/logo.png'),
      nextScreen: const Login(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: const Color(0xff0f151d),
    );
  }
}
