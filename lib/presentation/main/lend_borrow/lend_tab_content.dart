import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/lend/lend_screen.dart';
import 'package:test_project/presentation/main/home/widgets/token_tile.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/asset_tile.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/custom_textfield.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/panel_subtitle.dart';
import 'package:test_project/presentation/main/lend_borrow/widgets/stat.dart';

class LendTabContent extends ConsumerWidget {
  const LendTabContent({
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
                StatInfoWidget(title: "Total Lent", value: "\$0"),
                StatInfoWidget(title: "Collateral", value: "\$0"),
                StatInfoWidget(title: "Net APY", value: "0%")
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
                  initiallyExpanded: true,
                  title: Text(
                    "Your Suppliers",
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    const PanelSubTitleWidget(),
                    InkResponse(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const LendScreen())),
                        child: const AssetTile()),
                    const AssetTile(),
                    const AssetTile(),
                    const AssetTile(),
                    const AssetTile()
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Supply",
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    const PanelSubTitleWidget(),
                    InkResponse(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const LendScreen())),
                        child: const AssetTile()),
                    const AssetTile(),
                    const AssetTile(),
                    const AssetTile(),
                    const AssetTile()
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
