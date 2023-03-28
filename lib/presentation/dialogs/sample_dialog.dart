import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widget/button.dart';

void makeQRDialog(BuildContext context, String link) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 4,
                width: 60,
                color: Colors.white,
              ),
              const SizedBox(
                height: 52,
              ),
              Text(
                textAlign: TextAlign.center,
                "Share this social key image with trusted contacts",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                  width: 200, color: Colors.white, child: QrImage(data: link)),
              const SizedBox(
                height: 24,
              ),
              CustomButton(
                title: "Share",
                onClick: () => {},
                isLoading: false,
              )
            ],
          ),
        );
      });
}
