import 'package:inventory_plus/global_h.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const Color _facebookColor = Color(0xff6558f5);
const Color _twitterColor = Color(0xff1da1f2);
const Color _googleColor = Color(0xffd3455b);

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(automaticallyImplyLeading: false),
      body: ConstrainedBox(
        constraints: BoxConstraints.tight(MediaQuery.of(context).size),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -.2),
              child: _centerMatter(context),
            ),
            Align(
              alignment: const Alignment(0, 1),
              child: _bottomMatter(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerMatter(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Image.asset((Theme.of(context).brightness == Brightness.dark)
                ? 'assets/logo.png'
                : 'assets/logoDark.png'),
          ),
          const SizedBox(height: 4),
          const SizedBox(
            width: 256,
            child: _LoginForm(),
          ),
        ],
      ),
    );
  }

  static const double _buttonWidth = 188;
  static const double _buttonHeight = 44;
  static const double _padding = 8;

  Widget _bottomMatter(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(child: Text('Other Login Options')),
          const SizedBox(height: _padding),
          _externalAccount(context),
        ],
      ),
    );
  }

  Widget _externalAccount(BuildContext context) {
    Color labelColor = Theme.of(context).indicatorColor;
    TextStyle labelTextStyle =
        Theme.of(context).textTheme.titleMedium!.copyWith(color: labelColor);

    return SizedBox(
      width: _buttonWidth + _padding * 2,
      height: _buttonHeight * 3 + _padding * 4 - 4,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        shadowColor: Theme.of(context).shadowColor,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.tertiaryContainer,
                Theme.of(context).colorScheme.tertiary,
              ],
            ),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: _padding, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWrapper(
                fillColor: _facebookColor,
                splashColor: Theme.of(context).splashColor,
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(homeRoute),
                child: Container(
                  alignment: Alignment.center,
                  width: _buttonWidth,
                  height: _buttonHeight,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.facebook, color: labelColor),
                      const SizedBox(width: _padding),
                      Text('Facebook', style: labelTextStyle),
                    ],
                  ),
                ),
              ),
              ButtonWrapper(
                fillColor: _twitterColor,
                splashColor: Theme.of(context).splashColor,
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(homeRoute),
                child: Container(
                  alignment: Alignment.center,
                  width: _buttonWidth,
                  height: _buttonHeight,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.twitter, color: labelColor),
                      const SizedBox(width: _padding),
                      Text('Twitter', style: labelTextStyle),
                    ],
                  ),
                ),
              ),
              ButtonWrapper(
                fillColor: _googleColor,
                splashColor: Theme.of(context).splashColor,
                onPressed: () async {
                  Uri url =
                      Uri.parse('http://localhost:8080/oauth/login/google');

                  if (await canLaunchUrl(url)) {
                    /* bool successfulLaunch = */ await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Error calling Google's website")));
                  }
                  // can check the launchUrl success / error with a bool as shown above
                  // this isn't hooked up to the in-app User data (user_provider)
                  // could probably just make _fetchUser in user_provider.dart public,
                  // and call it here after successful launchUrl and google login
                },
                child: Container(
                  alignment: Alignment.center,
                  width: _buttonWidth,
                  height: _buttonHeight,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google, color: labelColor),
                      const SizedBox(width: _padding),
                      Text('Google', style: labelTextStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _externalAccount(BuildContext context) {
  //   const double minWidth = 200;
  //   const double minHeight = 0;
  //   const double vertPadding = 8;
  //   final double horizPadding =
  //       (MediaQuery.of(context).size.width - (minWidth + 8)) / 2.0;
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: horizPadding),
  //     child: Material(
  //       type: MaterialType.card,
  //       elevation: 1,
  //       surfaceTintColor: Theme.of(context).primaryColor,
  //       shadowColor: Theme.of(context).shadowColor,
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(
  //             color: Theme.of(context).colorScheme.tertiaryContainer),
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Column(
  //         children: [
  //           const SizedBox(height: 4),
  //           ElevatedButton.icon(
  //             icon: const Icon(FontAwesomeIcons.facebook),
  //             label: const Text('Facebook'),
  //             style: ElevatedButton.styleFrom(
  //               primary: _facebookColor,
  //               padding: const EdgeInsets.symmetric(vertical: vertPadding),
  //               elevation: 1,
  //               minimumSize: const Size(minWidth, minHeight),
  //               shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(8),
  //                   topRight: Radius.circular(8),
  //                 ),
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pushReplacementNamed(homeRoute);
  //             },
  //           ),
  //           const SizedBox(height: 4),
  //           ElevatedButton.icon(
  //             icon: const Icon(FontAwesomeIcons.twitter),
  //             label: const Text('Twitter'),
  //             style: ElevatedButton.styleFrom(
  //               primary: _twitterColor,
  //               padding: const EdgeInsets.symmetric(vertical: vertPadding),
  //               elevation: 1,
  //               minimumSize: const Size(minWidth, minHeight),
  //               shape: const RoundedRectangleBorder(),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pushReplacementNamed(homeRoute);
  //             },
  //           ),
  //           const SizedBox(height: 4),
  //           ElevatedButton.icon(
  //             icon: const Icon(FontAwesomeIcons.google),
  //             label: const Text('Google'),
  //             style: ElevatedButton.styleFrom(
  //               primary: _googleColor,
  //               padding: const EdgeInsets.symmetric(vertical: vertPadding),
  //               elevation: 1,
  //               minimumSize: const Size(minWidth, minHeight),
  //               shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(8),
  //                   bottomRight: Radius.circular(8),
  //                 ),
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pushReplacementNamed(homeRoute);
  //             },
  //           ),
  //           const SizedBox(height: 4),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(color: Theme.of(context).hintColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiaryContainer)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(4),
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4))),
              onPressed: _onPressed,
              child: const Text('Submit'),
            ),
          ),
        ),
        controller: _usernameController,
        validator: (_) => null,
      ),
    );
  }

  void _onPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
  }
}
