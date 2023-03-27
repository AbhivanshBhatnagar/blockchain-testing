import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomTextFieldWidget extends StatelessWidget {
  const MyCustomTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        autofocus: false,
        style: GoogleFonts.poppins(fontSize: 13),
        decoration: InputDecoration(
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
            fillColor: const Color(0xFF25252D),
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(fontSize: 13),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(22),
            ),
            suffixIcon: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFF37CBFA),
              child: Icon(
                Icons.search_sharp,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
