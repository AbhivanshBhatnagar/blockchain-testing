import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Messaging Comming soon.", style: GoogleFonts.inter(fontSize: 22),)));

    // return Scaffold(body: Text("Message "));
  }
}
