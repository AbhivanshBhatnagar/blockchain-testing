import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth_state.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends AuthState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(),
    );
  }

  @override
  void onAuthFailure() {
    // TODO: implement onAuthFailure
  }

  @override
  void onAuthSuccess() {
    // TODO: implement onAuthSuccess
  }
}
