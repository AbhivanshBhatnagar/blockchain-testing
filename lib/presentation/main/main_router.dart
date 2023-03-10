import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test_project/core/router.gr.dart';

class MainPageHostScreen extends StatelessWidget {
  const MainPageHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        appBarBuilder: ((context, tabsRouter) => AppBar(
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipOval(
                      child: CachedNetworkImage(
                    imageUrl:
                        "https://avatars.githubusercontent.com/u/64317542?v=4",
                  )),
                ),
              ),
              title: Text("Title"),
              backgroundColor: Colors.transparent,
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
              backgroundColor: Color(0xFF2F2C44),
              currentIndex: tabsRouter.activeIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "History"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "History"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "History"),
              ],
            ));
  }
}
