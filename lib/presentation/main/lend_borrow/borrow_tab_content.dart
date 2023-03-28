import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/borrow/borrow_screen.dart';
import 'package:test_project/presentation/main/home/widgets/token_tile.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/asset_tile.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/custom_textfield.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/panel_subtitle.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/stat.dart';

class BorrowTabContent extends ConsumerWidget {
  const BorrowTabContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle(
        style: GoogleFonts.inter(
            letterSpacing: 0, fontWeight: FontWeight.normal, height: 1),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.all(28),
              child: MyCustomTextFieldWidget(),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatInfoWidget(title: "Total\nBorrowed", value: "\$0"),
                  StatInfoWidget(title: "Can be\nborrowed", value: "\$0"),
                  StatInfoWidget(title: "Net\nAPY", value: "0%")
                ],
              ),
            ),
            const Divider(),
            Expanded(
                child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ExpansionTile(
                    title: Text(
                      "Your Borrows",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      const PanelSubTitleWidget(),
                      InkResponse(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const BorrowScreen())),
                          child: const AssetTile()),
                      const AssetTile(),
                      const AssetTile(),
                      const AssetTile(),
                      const AssetTile()
                    ],
                  ),
                  ExpansionTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    initiallyExpanded: true,
                    title: Text(
                      "Assets to borrow",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: const [
                      PanelSubTitleWidget(),
                      AssetTile(),
                      AssetTile(),
                      AssetTile(),
                      AssetTile(),
                      AssetTile(),
                      AssetTile(),
                    ],
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
