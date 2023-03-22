import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/presentation/auth/dynamic_link_proceessing/dynamic_link_processing_state_notifier.dart';

class DynamicLinkProcessingScreen extends ConsumerStatefulWidget {
  const DynamicLinkProcessingScreen({
    required this.authToken,
    Key? key,
  }) : super(key: key);
  final String authToken;

  @override
  ConsumerState createState() => _DynamicLinkProcessingScreenState();
}

class _DynamicLinkProcessingScreenState
    extends ConsumerState<DynamicLinkProcessingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () => ref
                .read(dynamicLinkProcessingStateNotifierProvider.notifier)
                .verifyDynamicLink(),
            child: CircularProgressIndicator()),
      ),
    );
  }
}
