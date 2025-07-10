import 'package:bellefu/pages/dashboard/replays.dart';
import 'package:bellefu/pages/dashboard/up_coming.dart';
import 'package:bellefu/pages/playradio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _page = 0;
  List<Widget> pageTabs = [UpComing(), PlayRadio(), Replays()]; //

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Text('page $index'); // FeedPage(
      /*scaffoldKey: _scaffoldKey,
          refreshIndicatorKey: refreshIndicatorKey,
        );*/
      case 1:
        return Text('page $index'); // SearchPage(scaffoldKey: _scaffoldKey);
      case 2:
        return Text('page $index'); // NotificationPage(scaffoldKey: _scaffoldKey);
      default:
        return Text('page $index'); // FeedPage(scaffoldKey: _scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit the App?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.red,
                    ), //specify the button's text TextStyle
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.red),
                    ), // set the buttons shape. Make its birders rounded etc
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "NO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffffb700),
                      fontSize: 18,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.red,
                    ), //specify the button's text TextStyle
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                        color: Color(0xff76b91b),
                      ),
                    ), // set the buttons shape. Make its birders rounded etc
                  ),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    SystemNavigator.pop();
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "YES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return new WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFCFFF6),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: pageTabs,
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Theme.of(context).primaryColor,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Theme.of(context).colorScheme.secondary,
              textTheme: Theme.of(context).textTheme.copyWith(
                    caption: TextStyle(color: Colors.grey[500]),
                  ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF20222C), // Color(0xFF0A0A36), // Color(0xFF6200EE), Color(0xff76B91B), //
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 4.0,
              unselectedFontSize: 4.0,
              currentIndex: _page,
              selectedItemColor: Colors.amber[800],
              onTap: navigationTapped,

              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  // title: Container(height: 0.0),
                  label: '',
                  icon: Image.asset(
                    'assets/home.png',
                    color: Colors.white54,
                  ),
                  activeIcon: Image.asset(
                    'assets/home.png',
                    color: Colors.white,
                  ),
                ),
                BottomNavigationBarItem(
                  // title: Container(height: 0.0),
                  label: '',
                  icon: Image.asset(
                    'assets/play_it.png',
                    width: 62.0,
                    height: 62.0,
                  ),
                  activeIcon: Image.asset(
                    'assets/play_it.png',
                    width: 62.0,
                    height: 62.0,
                  ),
                ),
                BottomNavigationBarItem(
                  // title: Container(height: 0.0),
                  label: '',
                  icon: Image.asset(
                    'assets/replay-all.png',
                    color: Colors.white54,
                  ),
                  activeIcon: Image.asset(
                    'assets/replay-all.png',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    if (page == 1) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlayRadio()));
      setState(() {
        this._page = 0;
      });
    } else {
      _getPage(page);

      _pageController.jumpToPage(page);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
