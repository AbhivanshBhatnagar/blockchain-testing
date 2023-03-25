import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.onValidatorString = "This must not be empty!",
      this.hint,
      this.height = 50,
      this.width = 200,
      this.radius = 15,
      this.isFilled = true,
      this.suffix,
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
  final bool? isFilled;
  final IconData? suffix;
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
            suffixIcon: suffix != null ? Icon(suffix) : null,
            alignLabelWithHint: true,
            hintStyle: GoogleFonts.inter(
                color: const Color.fromRGBO(102, 99, 99, 1),
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
            hintText: hint,
            fillColor: isFilled! ? const Color(0xFF222529) : Colors.transparent,
            filled: isFilled,
            border: OutlineInputBorder(
                borderSide: !isFilled!
                    ? const BorderSide(
                        color: Color.fromRGBO(44, 43, 50, 1),
                        width: 2,
                      )
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(radius!))),
      ),
    );
  }
}
