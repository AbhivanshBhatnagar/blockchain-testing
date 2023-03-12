import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/presentation/main/home/widgets/home_tabs.dart';
import 'package:test_project/presentation/main/home/widgets/symbol_button.dart';
import 'dart:math' as math;
import 'widgets/account_card.dart';

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
                delegate: _SliverAppBarDelegate(
                  minHeight: 185,
                  maxHeight: 90,
                  child: const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AccountCard(),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
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
                            children: [
                              SymbolButton(
                                  title: "Add Funds",
                                  icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Send", icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Receive",
                                  icon: Icon(Icons.credit_card)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SymbolButton(
                                  title: "Add Funds",
                                  icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Send", icon: Icon(Icons.credit_card)),
                              const SizedBox(
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
                delegate: _SliverAppBarDelegate(
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
                delegate: _SliverAppBarDelegate(
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
              ListView.builder(key: new PageStorageKey('myListView1'),itemBuilder: (context, index) {
                return ListTile(
                  title: Text('ListTile${index}'),
                  isThreeLine: true,
                  subtitle: Text('Secondary text\nTertiary text'),
                  leading: ClipOval(
                      child: CachedNetworkImage(
                    imageUrl:
                        "https://cloudfront-us-east-1.images.arcpublishing.com/coindesk/ZJZZK5B2ZNF25LYQHMUTBTOMLU.png",
                  )),
                  trailing: Text('Metadata'),
                );
              }),
              ListView.builder(key: new PageStorageKey('myListView2'),itemBuilder: (context, index) {
                return ListTile(
                  title: Text('ListTile${index}'),
                  isThreeLine: true,
                  subtitle: Text('Secondary text\nTertiary text'),
                  leading: ClipOval(
                      child: CachedNetworkImage(
                    imageUrl:
                        "https://cloudfront-us-east-1.images.arcpublishing.com/coindesk/ZJZZK5B2ZNF25LYQHMUTBTOMLU.png",
                  )),
                  trailing: Text('Metadata'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
// children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: AccountCard(),
//             ),
//             Container(
//               height: 90,
//               child: PageView(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SymbolButton(
//                           title: "Add Funds", icon: Icon(Icons.credit_card)),
//                       SymbolButton(title: "Send", icon: Icon(Icons.credit_card)),
//                       SymbolButton(
//                           title: "Receive", icon: Icon(Icons.credit_card)),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SymbolButton(
//                           title: "Add Funds", icon: Icon(Icons.credit_card)),
//                       SymbolButton(title: "Send", icon: Icon(Icons.credit_card)),
//                       SymbolButton(
//                           title: "Receive", icon: Icon(Icons.credit_card)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),