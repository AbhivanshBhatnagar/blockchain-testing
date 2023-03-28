import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});
  final apiKey="xvr2y5z85exp";
  final secret="4txfzey7zku4vaxj9pgzk3juw8k9aum3m8a6s425fz3bs65j2h48cnve27wu5nj3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Messaging Comming soon.", style: GoogleFonts.inter(fontSize: 22),)));
    
  }
}
