import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/presentation/main/home/widgets/home_tabs.dart';
import 'package:test_project/presentation/main/home/widgets/symbol_button.dart';

import 'widgets/account_card.dart';

List<String> tabsTexts = ["Posts", "IGTV", "Saved"];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabsTexts.length);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AccountCard(),
          ),
          Container(
            height: 90,
            child: PageView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SymbolButton(
                        title: "Add Funds", icon: Icon(Icons.credit_card)),
                    SymbolButton(title: "Send", icon: Icon(Icons.credit_card)),
                    SymbolButton(
                        title: "Receive", icon: Icon(Icons.credit_card)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SymbolButton(
                        title: "Add Funds", icon: Icon(Icons.credit_card)),
                    SymbolButton(title: "Send", icon: Icon(Icons.credit_card)),
                    SymbolButton(
                        title: "Receive", icon: Icon(Icons.credit_card)),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          HomeTabs(tabController: _tabController),
          // TabBarView(
          //   controller: _tabController,
          //   children: <Widget>[
          //     ListView.builder(
          //         itemBuilder: (context, index) => ListTile(
          //             leading: const Icon(Icons.flight_land),
          //             title: const Text("Trix's airplane"),
          //             subtitle: const Text('The airplane is only in Act II.'),
          //             onTap: () => print("ListTile")))
          //   ],
          // )
        ],
      ),
    );
  }
}
