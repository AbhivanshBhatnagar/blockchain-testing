import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test_project/core/router.gr.dart';

class MainPageHostScreen extends StatelessWidget {
  MainPageHostScreen({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        homeIndex: 2,
        drawer: Drawer(
            elevation: 4,
            child: ListView(
              children: [
                ListTile(
                  // leading: Icon(Icons.message),
                  title: Text('Messages'),
                ),
                ListTile(
                  // leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
                ListTile(
                  // leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            )),
        appBarBuilder: ((context, tabsRouter) => AppBar(
              backgroundColor: Colors.transparent,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {},
                    child: ClipOval(
                        child: CachedNetworkImage(
                      imageUrl:
                          "https://avatars.githubusercontent.com/u/64317542?v=4",
                    )),
                  ),
                ),
              ),
              title: Text("Text"),
              elevation: 0,
              centerTitle: true,
            )),
        routes: const [
          SearchRoute(),
          MessageRoute(),
          HomeRoute(),
          NotificationRoute(),
          SettingsRoute()
        ],
        bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
              },
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white30,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message), label: "Message"),
                BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none),
                    label: "Notification"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],
            ));
  }
}
