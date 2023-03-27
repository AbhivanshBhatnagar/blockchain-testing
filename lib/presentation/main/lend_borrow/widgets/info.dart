import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LendBorrowInfo extends ConsumerWidget {
  const LendBorrowInfo({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle(
      style: GoogleFonts.inter(
          letterSpacing: 0, fontWeight: FontWeight.normal, height: 1),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF37CBFA),
              ),
              const SizedBox(width: 5),
              Text(
                title,
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(fontSize: 15),
              )
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value,
            textAlign: TextAlign.left,
            style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
