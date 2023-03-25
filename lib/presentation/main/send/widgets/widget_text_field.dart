import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    Key? key,
    required this.child,
    this.controller,
    this.onValidatorString = "This must not be empty!",
    this.hint,
    this.height = 50,
    this.width = 200,
    this.onTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final double? height;
  final double? width;
  final String? onValidatorString;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: const Color.fromRGBO(44, 43, 50, 1),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              child,
              Center(
                  child: SizedBox(
                      width: 100,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: GoogleFonts.inter(
                                color: const Color.fromRGBO(102, 99, 99, 1),
                                fontSize: 25,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                            border: InputBorder.none),
                      ))),
              const SizedBox(width: 10)
            ],
          )),
    );
  }
}
