import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PanelSubTitleWidget extends ConsumerWidget {
  const PanelSubTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 16, 48, 16),
      child: Row(
        children: [
          Text(
            'Asset',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(height: 1.5, color: Colors.white),
          ),
          Expanded(child: Container()),
          Text(
            'APY',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(height: 1.5, color: Colors.white),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
