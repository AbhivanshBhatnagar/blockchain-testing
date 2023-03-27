import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mccounting_text/mccounting_text.dart';

class BorrowScreen extends ConsumerStatefulWidget {
  const BorrowScreen({super.key});

  @override
  ConsumerState<BorrowScreen> createState() => _LendBorrowScreenState();
}

class _LendBorrowScreenState extends ConsumerState<BorrowScreen>
    with SingleTickerProviderStateMixin {
  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Borrow",
            style: GoogleFonts.inter(fontSize: 24),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/dai.png"),
                ),
                const SizedBox(height: 16),
                Text(
                  'DAI',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter()
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\$",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    McCountingText(
                      textAlign: TextAlign.center,
                      begin: 0,
                      end: 1000,
                      style: GoogleFonts.inter()
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                      duration: const Duration(seconds: 1),
                      curve: Curves.decelerate,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_drop_up,
                      color: Color(0xFF03A200),
                    ),
                    Text(
                      '2.22%',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter()
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 42),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'APY',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '0%',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'LTV',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '0%',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Balance',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '0',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 28),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 142,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222529),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Total tokens borrowed : 1000', //to be replaced with concatenation
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            const Spacer(
                              flex: 2,
                            ),
                            Text(
                                'Available liquidity : \$52.4M', //to be replace with exact values
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Using as collateral', //to be replace with exact values
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                          Switch(value: false, onChanged: (value) {})
                        ],
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(47)),
                            color: const Color(0xFF37CBFA),
                            onPressed: () {},
                            child: Text("Borrow",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          ),
                          MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(47)),
                            color: const Color(0xFF37CBFA),
                            onPressed: () {},
                            child: Text("Repay",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          ),
                          MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(47)),
                            color: const Color(0xFF37CBFA),
                            onPressed: () {},
                            child: Text("Buy",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
