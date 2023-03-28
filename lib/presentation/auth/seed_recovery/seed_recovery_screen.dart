import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/native/android/android_google_drive_platform_channel.dart';
import 'package:test_project/presentation/auth/seed_recovery/seed_recovery_state_notifier.dart';
import 'package:test_project/services/local_services/encrypted_shared_pref.dart';

import '../../../core/router.gr.dart';
import '../../dialogs/sample_dialog.dart';
import '../../widget/button.dart';

class SeedRecoveryScreen extends ConsumerStatefulWidget {
  const SeedRecoveryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SeedRecoveryScreenState();
}

class _SeedRecoveryScreenState extends ConsumerState<SeedRecoveryScreen> {
  @override
  void initState() {
    super.initState();
    // ignore: missing_return
    AndroidGoogleDrivePlatformChannel.platform
        .setMethodCallHandler((call) async {
      switch (call.method) {
        case "signInWithGoogle_success":
          AndroidGoogleDrivePlatformChannel.uploadNewKeysInGDrive(
              "keys.txt", ref.read(seedRecoveryStateNotifierProvider).driveKey);
          break;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    int step = ref.watch(
        seedRecoveryStateNotifierProvider.select((value) => value.noOfSteps));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text(
                    "Setup Seedless Recovery",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child:
                    Text("To backup your wallet complete all the steps below"),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      color: Color(0xFF33BB7A),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Text(
                          "$step of 3 completed",
                          style: GoogleFonts.inter(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              // for (int i = 0; i < 3; i++)
              GestureDetector(
                onTap: () {
                  ref
                      .read(seedRecoveryStateNotifierProvider.notifier)
                      .driveRecovery();
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                      child: Row(children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Icon(Icons.lock),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Cloud Key"),
                            subtitle: Text(
                                "Securely store the cloud key on your Google Drive"),
                          ),
                        )
                      ]),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  makeQRDialog(context,
                      ref.read(seedRecoveryStateNotifierProvider).qrKey);
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                      child: Row(children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Icon(Icons.launch),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Social Key"),
                            subtitle: Text(
                                "Use QR Code to share social key with your trusted contacts"),
                          ),
                        )
                      ]),
                    )),
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                    child: Row(children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Icon(Icons.face),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("Signin with FaceID"),
                        ),
                      )
                    ]),
                  )),
              Expanded(child: Container()),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                onClick: () {
                  ref
                      .read(encryptedSharedPrefProvider)
                      .instance
                      .setString("isAuthCheck", "true");
                  AutoRouter.of(context).pushAndPopUntil(MainRouter(),
                      predicate: (route) => false);
                },
                title: "Go to Home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
