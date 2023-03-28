import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_project/presentation/widget/button.dart';

class CustomAccountDetailsCard extends ConsumerWidget {
  const CustomAccountDetailsCard(
      {super.key,
      this.accountAddress,
      this.accountName,
      this.assets,
      this.currentBalance});

  final String? accountName;
  final String? accountAddress;
  final double? currentBalance;
  final List<Widget>? assets;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 146,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color.fromRGBO(34, 37, 41, 1),
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.inter(
            color: Colors.white,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/monkey.png"),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Name',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter().copyWith(fontSize: 17),
                    ),
                    const SizedBox(height: 5),
                    Text('accc..2qgtxg',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter().copyWith(fontSize: 12))
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "\$",
                      style: GoogleFonts.inter().copyWith(height: 1),
                    ),
                    McCountingText(
                      begin: 0,
                      end: Random().nextDouble() * 100,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter().copyWith(fontSize: 22),
                    ),
                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 45),
                Stack(
                  alignment: Alignment.centerLeft,
                  clipBehavior: Clip.none,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Icon(
                        Icons.table_view,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      left: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 20,
                        child: Icon(
                          Icons.biotech,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Icon(
                          Icons.currency_bitcoin,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55)),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        useRootNavigator: true,
                        enableDrag: true,
                        elevation: 3,
                        shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(31),
                                topRight: Radius.circular(31))),
                        context: context,
                        builder: (context) {
                          return DraggableScrollableSheet(
                              expand: false,
                              snap: true,
                              minChildSize: 0,
                              initialChildSize: .67,
                              maxChildSize: .67,
                              builder: (context, scrollController) {
                                return DefaultTextStyle(
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 4,
                                          width: 60,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Text(
                                          'Receive',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.inter().copyWith(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Account Name',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.inter(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        InkResponse(
                                          onTap: () {
                                            _openSelectNetworkSheet(context);
                                          },
                                          child: Container(
                                            width: 200,
                                            height: 28,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(34),
                                              color: const Color.fromRGBO(
                                                  17, 16, 19, 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Ethereum Mainnet',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter()
                                                      .copyWith(fontSize: 13),
                                                ),
                                                const SizedBox(width: 12),
                                                Transform.rotate(
                                                    angle: -(pi / 2),
                                                    child: const Icon(
                                                      Icons.arrow_back_ios,
                                                      size: 13,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  width: 5,
                                                  color: const Color.fromRGBO(
                                                      55, 203, 250, 0.6),
                                                )),
                                            child: QrImage(
                                                data:
                                                    "https://www.google.com")),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Text(
                                          "0xd81673Cee109A718AbECeb626dbE62E978079865",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w200,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(100)),
                                              color: const Color(0xFF37CBFA),
                                              height: 36,
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.money),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Request payment",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(100)),
                                              color: const Color(0xFF37CBFA),
                                              height: 36,
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.share),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Share Wallet Address",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  },
                  color: const Color(0xFF28809E),
                  child: Text(
                    "Receive",
                    style: GoogleFonts.inter()
                        .copyWith(fontSize: 11, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _openSelectNetworkSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        enableDrag: true,
        elevation: 3,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(31), topRight: Radius.circular(31))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              snap: true,
              minChildSize: 0,
              initialChildSize: .6,
              maxChildSize: .6,
              builder: (context, scrollController) {
                return DefaultTextStyle(
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 24, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 4,
                          width: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select Network',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter().copyWith(
                                fontSize: 19, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                            child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return const ListTile(
                                    title: Text("Ethereum Main"),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/diamond.png"),
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
