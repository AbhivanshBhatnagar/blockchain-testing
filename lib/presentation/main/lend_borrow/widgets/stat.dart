import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class StatInfoWidget extends ConsumerWidget {
  const StatInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle(
      style: GoogleFonts.inter(
          letterSpacing: 0, fontWeight: FontWeight.normal, height: 1),
      child: Column(
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 15),
          )
        ],
      ),
    );
  }
}
