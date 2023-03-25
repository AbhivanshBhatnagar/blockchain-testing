import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends ConsumerWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onClick,
    this.titleColor = Colors.white,
    this.color = const Color(0xFF2C83A0),
  });
  final Function onClick;
  final String title;
  final Color? color;
  final Color? titleColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () => {onClick()},
      child: Text(
        title,
        style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.bold, color: titleColor),
      ),
    );
  }
}
