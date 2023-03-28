import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/presentation/main/home/widgets/home_tabs.dart';
import 'package:test_project/presentation/main/home/widgets/symbol_button.dart';
import 'widgets/account_card.dart';
import 'widgets/sliver_app_bar_delegate.dart';
import 'widgets/token_tile.dart';

List<String> tabsTexts = ["Tokens", "NFTs"];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _sendReceivePagePosition = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 185,
                  maxHeight: 90,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: AccountCard(),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 100,
                  maxHeight: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 100,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) => setState(() {
                          _sendReceivePagePosition = value.toDouble();
                        }),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              SymbolButton(
                                  title: "Add Funds",
                                  icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Send",
                                  icon: Icon(Icons.arrow_outward)),
                              SymbolButton(
                                  title: "Receive",
                                  icon: RotatedBox(
                                    child: Icon(Icons.arrow_outward),
                                    quarterTurns: 2,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              SymbolButton(
                                  title: "Lend and Borrow",
                                  icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Swap", icon: Icon(Icons.swap_horiz)),
                              SizedBox(
                                width: 50,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 37,
                  maxHeight: 37,
                  child: Column(
                    children: [
                      DotsIndicator(
                        dotsCount: 2,
                        position: _sendReceivePagePosition,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 5.0),
                          activeColor: Color(0xFF37CBFA),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 50,
                    maxHeight: 50,
                    child: HomeTabs(
                      tabController: _tabController,
                    )),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                  key: const PageStorageKey('myListView1'),
                  itemBuilder: (context, idx) {
                    return TokenTile(
                      index: idx,
                    );
                  }),
              ListView.builder(
                  key: const PageStorageKey('myListView2'),
                  itemBuilder: (context, index) {
                    return TokenTile(
                      index: index,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
