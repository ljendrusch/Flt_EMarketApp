import 'package:inventory_plus/global_h.dart';

const int _numTabs = 4;
const int _tabsLastIndex = _numTabs - 1;

class HomeScaffold extends StatefulWidget {
  final dynamic args;

  const HomeScaffold({super.key, this.args});

  @override
  State<HomeScaffold> createState() => HomeScaffoldState();

  static HomeScaffoldState? of(BuildContext context) =>
      context.findAncestorStateOfType<HomeScaffoldState>();
}

class HomeScaffoldState extends State<HomeScaffold> {
  int activePageIndex = 0;
  int currentTabIndex = 0;

  @override
  void initState() {
    if (widget.args != null) activePageIndex = widget.args as int;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  void moveToTab(int index) {
    if (index < _tabsLastIndex) {
      setState(() {
        activePageIndex = index;
        currentTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: [
        const Home(),
        const Inventory(),
        const Search(),
      ][activePageIndex],
      endDrawer: const _EndDrawer(),
      endDrawerEnableOpenDragGesture: false,
      onEndDrawerChanged: (scaffoldOpening) {
        if (!scaffoldOpening) {
          setState(() {
            currentTabIndex = activePageIndex;
          });
        }
      },
      bottomNavigationBar: Builder(
        builder: (context) => NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentTabIndex = index;
              if (index < _tabsLastIndex) {
                activePageIndex = index;
              } else {
                Scaffold.of(context).openEndDrawer();
              }
            });
          },
          selectedIndex: currentTabIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Inventory',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        ['Home', 'Inventory', 'Search'][activePageIndex],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        const CodeScanner(size: 28),
        const SizedBox(width: 4),
        PopupMenuButton<int>(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: const Icon(Icons.add_circle_outline, size: 30),
          onSelected: (index) => (index == 0)
              ? Navigator.of(context).pushNamed(itemFormRoute)
              : Navigator.of(context).pushNamed(tagFormRoute),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('Add an Item'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('Make a Tag'),
            ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}

class _EndDrawer extends StatelessWidget {
  const _EndDrawer();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context).user;

    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * .04),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const ScrollPhysics(),
          children: [
            ButtonWrapper(
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              splashColor: Theme.of(context).splashColor,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(profileRoute);
              },
              child: ConstrainedBox(
                constraints:
                    BoxConstraints.tightFor(height: screenHeight * .18),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(
                          Size.square(screenHeight * .15),
                        ),
                        child: ClipPath(
                          clipper: ClipCircleBottomChorded(),
                          clipBehavior: Clip.antiAlias,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: user.image,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          (user.name.isWhitespace())
                              ? 'No User Data'
                              : user.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              thickness: 2,
              indent: 8,
              endIndent: 8,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            SwitchListTile(
                title: const Text('Dark Theme'),
                value: Provider.of<LocalSettings>(context).themeMode ==
                    ThemeMode.dark,
                onChanged: (switchingOn) {
                  (switchingOn)
                      ? Provider.of<LocalSettings>(context, listen: false)
                          .setThemeMode(ThemeMode.dark)
                      : Provider.of<LocalSettings>(context, listen: false)
                          .setThemeMode(ThemeMode.light);
                }),
            ListTile(
              title: const Text('Help Center'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, helpCenterRoute);
              },
            ),
            ListTile(
              title: const Text('Terms of Service'),
              onTap: () {
                //do a text popup
              },
            ),
            ListTile(
              title: const Text('Privacy'),
              onTap: () {
                //do a text popup
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, loginRoute);
              },
            ),
            const AboutListTile(
              applicationIcon: Icon(Icons.add_task),
              applicationName: 'Inventory +',
              applicationVersion: '0.82b',
              applicationLegalese: 'For use under NDA only',
            ),
          ],
        ),
      ),
    );
  }
}

class ClipCircleBottomChorded extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.addArc(Rect.fromLTWH(0, 0, w, h), pi * 3 / 4, pi * 3 / 2);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
