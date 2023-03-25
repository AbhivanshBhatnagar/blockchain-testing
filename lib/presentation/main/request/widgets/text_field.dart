import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.onValidatorString = "This must not be empty!",
      this.hint,
      this.height = 52.0,
      this.width = 200,
      this.radius = 15,
      this.onClick,
      this.icon})
      : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final double? height;
  final double? width;
  final String? onValidatorString;
  final IconData? icon;
  final VoidCallback? onClick;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        onTap: onClick,
        validator: (value) {
          if (value!.isEmpty) {
            return onValidatorString!;
          }
          return null;
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            alignLabelWithHint: true,
            hintStyle: GoogleFonts.inter(
                color: const Color.fromRGBO(117, 117, 117, 1),
                fontSize: 16,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
            hintText: hint,
            fillColor: const Color(0xFF222529),
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(radius!))),
      ),
    );
  }
}
