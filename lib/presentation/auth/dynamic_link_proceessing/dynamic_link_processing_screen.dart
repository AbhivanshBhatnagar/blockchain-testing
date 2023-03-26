import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/core/router.gr.dart';
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
  void initState() {
    super.initState();
    ref
        .read(dynamicLinkProcessingStateNotifierProvider.notifier)
        .verifyDynamicLink(widget.authToken);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(dynamicLinkProcessingStateNotifierProvider, (previous, next) {
      if (next.status == DynamicLinkProcessingStateNotifierStatus.error) {
        // debugPrint("ERROR MESAAGE");
        Future.delayed(Duration(milliseconds: 500), () {
          AutoRouter.of(context).pushAndPopUntil(const SignupRoute(),
              predicate: (route) => false);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.errorMessage.toString()),
          duration: const Duration(milliseconds: 300),
        ));
        // AutoRouter.of(context).navigateBack();
      }
      if (next.status == DynamicLinkProcessingStateNotifierStatus.loaded) {
        final userExistInBackend=ref.read(dynamicLinkProcessingStateNotifierProvider.select((value) => value.userExistsInBackend));
        if(userExistInBackend){
          Future.delayed(const Duration(milliseconds: 500), () {
            AutoRouter.of(context).pushAndPopUntil(const RecoverAccountRoute(),
                predicate: (route) => false);
          });
        }
        else {
          Future.delayed(const Duration(milliseconds: 500), () {
          AutoRouter.of(context).pushAndPopUntil(const SetupOrImportNewAccountRoute(),
              predicate: (route) => false);
        });
        }
        debugPrint("dynamic link api done. ");

      }
      if (next.status ==
          DynamicLinkProcessingStateNotifierStatus.dynamicLinkVerified) {
        ref
            .read(dynamicLinkProcessingStateNotifierProvider.notifier)
            .checkWhetherUserExists();
        debugPrint("deep link successful");
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
