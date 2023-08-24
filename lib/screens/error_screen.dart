import 'package:inventory_plus/global_h.dart';

class ErrorPage extends StatelessWidget {
  final String errorString;

  const ErrorPage({super.key, required this.errorString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(child: Text('Page switch error on $errorString')),
    );
  }
}
