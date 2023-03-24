import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/home/widgets/sliver_app_bar_delegate.dart';
import 'package:test_project/presentation/main/home/widgets/symbol_button.dart';
import 'package:test_project/presentation/main/token/widgets/activity_tile.dart';

class TokenScreen extends ConsumerWidget {
  const TokenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
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
                      minHeight: size.height * .40,
                      maxHeight: size.height * .40,
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
                                const SizedBox(height: 42),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    SymbolButton(
                                      title: "Buy",
                                      icon: Icon(Icons.credit_card),
                                    ),
                                    SymbolButton(
                                      title: "Send",
                                      icon: Icon(Icons.send),
                                    ),
                                    SymbolButton(
                                      title: "Receive",
                                      icon: Icon(Icons.credit_card),
                                    ),
                                    SymbolButton(
                                      title: "'More",
                                      icon: Icon(Icons.more),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      )))
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
