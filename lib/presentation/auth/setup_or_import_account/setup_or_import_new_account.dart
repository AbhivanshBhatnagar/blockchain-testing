import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/router.gr.dart';
import '../../widget/button.dart';

class SetupOrImportNewAccountScreen extends ConsumerStatefulWidget {
  const SetupOrImportNewAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetupOrImportNewAccountScreenState();
}

class _SetupOrImportNewAccountScreenState
    extends ConsumerState<SetupOrImportNewAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C83A0),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    size: 62,
                    Icons.wallet,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Hey Anonymous, let's get you started",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 40),
              ),
              Text(
                "Quickly, connect or restore a wallet",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Expanded(child: Container()),
         
              Text(
                "Sent to xyz@gmail.com",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFFDEDEDE)),
              ),
              SizedBox(
                height: 12,
              ),
              CustomButton(
                  onClick: () =>
                      {AutoRouter.of(context).push(SeedRecoveryRoute())},
                  title: "Create new Wallet",
                  isLoading: false),
              CustomButton(
                  onClick: () =>
                      {AutoRouter.of(context).push(SeedRecoveryRoute())},
                  title: "Restore existing wallet",
                  isLoading: false),
            ],
          ),
        ),
      ),
    );
  }
}
