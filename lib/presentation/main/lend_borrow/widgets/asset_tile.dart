import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetTile extends ConsumerWidget {
  const AssetTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/dai.png"),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                'FTX',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                '4000',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter().copyWith(
                  fontSize: 12,
                  height: 1.3,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            '9.87%',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter().copyWith(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Spacer(),
          MaterialButton(
            minWidth: 65,
            color: const Color(0xFF37CBFA),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {},
            child: Text(
              'Supply',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter().copyWith(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
