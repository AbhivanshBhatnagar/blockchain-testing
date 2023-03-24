import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipButton extends ConsumerWidget {
  const ChipButton({super.key, this.label, this.onPressed});

  final String? label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.width * .4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31)),
      color: const Color.fromRGBO(55, 203, 250, 0.6),
      onPressed: onPressed,
      child: Text(
        label!,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins().copyWith(height: 1.7, fontSize: 14),
      ),
    );
  }
}
