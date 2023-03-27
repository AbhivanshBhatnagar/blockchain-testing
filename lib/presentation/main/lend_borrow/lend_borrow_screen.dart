import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/home/widgets/sliver_app_bar_delegate.dart';
import 'package:test_project/presentation/main/home/widgets/token_tile.dart';
import 'package:test_project/presentation/main/lend_borrow/borrow_tab_content.dart';
import 'package:test_project/presentation/main/lend_borrow/lend_tab_content.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/info.dart';
import 'package:test_project/presentation/widget/custom_tab.dart';

List<String> tabsTexts = ["Lend", "Borrow"];

class LendBorrowScreen2 extends ConsumerStatefulWidget {
  const LendBorrowScreen2({super.key});

  @override
  ConsumerState<LendBorrowScreen2> createState() => _LendBorrowScreenState();
}

class _LendBorrowScreenState extends ConsumerState<LendBorrowScreen2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
              SliverAppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "Lend and Borrow",
                  style: GoogleFonts.inter(fontSize: 24),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 24),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 100,
                  maxHeight: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          LendBorrowInfo(
                              title: "Net\nWorth",
                              icon: Icons.wallet_outlined,
                              value: "\$0"),
                          LendBorrowInfo(
                              title: "Net\nAPY",
                              icon: Icons.network_cell_outlined,
                              value: "0%"),
                          LendBorrowInfo(
                              title: "H.F",
                              icon: Icons.wallet_outlined,
                              value: "0")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 24,
                  maxHeight: 24,
                  child: const Divider(),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 50,
                    maxHeight: 50,
                    child: CustomTab(
                      tabs: tabsTexts,
                      tabController: _tabController,
                    )),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [LendTabContent(), BorrowTabContent()],
          ),
        ),
      ),
    );
  }
}
