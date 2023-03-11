import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymbolButton extends StatelessWidget {
  const SymbolButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            color: Color(0xFF37CBFA),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.credit_card),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text("Add Funds",
            style:
                GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w600))
      ],
    );
  }
}
