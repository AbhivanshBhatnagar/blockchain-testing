import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/home/widgets/sliver_app_bar_delegate.dart';
import 'package:test_project/presentation/main/home/widgets/symbol_button.dart';
import 'package:test_project/presentation/main/token/widgets/activity_tile.dart';

class TokenScreen extends ConsumerStatefulWidget {
  const TokenScreen({super.key});

  @override
  ConsumerState<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends ConsumerState<TokenScreen>
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
    final size = MediaQuery.of(context).size;

    double _sendReceivePagePosition = 0;
    return Scaffold(
        // backgroundColor: const Color(0xFF111013),
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                forceElevated: innerBoxIsScrolled,
                centerTitle: true,
                title: const Text("ETHEREUM"),
                backgroundColor: Colors.transparent,
              ),
              SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                      minHeight: size.height * .25,
                      maxHeight: size.height * .25,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DefaultTextStyle(
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                letterSpacing: 0,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                height: 1),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage('assets/eth.png'),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '10 ETH',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins()
                                      .copyWith(fontSize: 32),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '₹0.0738',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 63,
                                  height: 22,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    color: Color(0xFF37CBFA),
                                  ),
                                  child: Text(
                                    '+0.47%',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins().copyWith(
                                        fontSize: 11, color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ))),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 100,
                  maxHeight: 50,
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
                                  title: "Send", icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Receive",
                                  icon: Icon(Icons.credit_card)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              SymbolButton(
                                  title: "Lend and Borrow",
                                  icon: Icon(Icons.credit_card)),
                              SymbolButton(
                                  title: "Swap", icon: Icon(Icons.credit_card)),
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
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Activities',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Inter',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Flexible(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => const ActivityCard())),
              ],
            ),
          ),
        ));
  }
}
