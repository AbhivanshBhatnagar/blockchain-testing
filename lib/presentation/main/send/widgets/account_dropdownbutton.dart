import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDropDownButton extends ConsumerWidget {
  const AccountDropDownButton({super.key, this.onSelected, this.onTap});

  final VoidCallback? onTap;
  final Function(String account)? onSelected; //to be replaced

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/monkey.png"),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account 1',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '0x23323...9865',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                      color: const Color.fromRGBO(102, 99, 99, 1),
                      fontSize: 10,
                    ),
                  )
                ],
              ),
              const Spacer(),
              const Center(
                  child: Icon(
                Icons.arrow_downward,
                size: 11,
              )),
              const SizedBox(width: 10)
            ],
          )),
    );
  }
}
