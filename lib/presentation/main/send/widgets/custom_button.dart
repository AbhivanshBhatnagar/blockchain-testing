import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomActionButton extends ConsumerWidget {
  const CustomActionButton({super.key, this.buttonStyle, required this.label});

  final CustomButtonStyle? buttonStyle;
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 163,
      height: 43,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: buttonStyle == CustomButtonStyle.filled
              ? const Color.fromRGBO(55, 203, 250, 0.6)
              : Colors.transparent,
          border: buttonStyle != CustomButtonStyle.filled
              ? Border.all(
                  color: const Color.fromRGBO(55, 203, 250, 1),
                  width: 1,
                )
              : null),
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: GoogleFonts.inter(
            color: buttonStyle == CustomButtonStyle.filled
                ? Colors.white
                : const Color.fromRGBO(55, 203, 250, 0.6),
            fontSize: 18,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
    );
  }
}

enum CustomButtonStyle { outlined, filled }
