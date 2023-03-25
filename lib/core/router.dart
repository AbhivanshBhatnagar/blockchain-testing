import 'package:auto_route/auto_route.dart';
import 'package:test_project/presentation/auth/restore_existing_account_screen.dart';
import '../presentation/main/main_router.dart';
import '../presentation/presentation.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: [
  AutoRoute(path: '/', page: SplashScreen),
  AutoRoute(path: '/signup', page: SignupScreen),
  AutoRoute(path: '/dynamic_link_processing_screen', page: DynamicLinkProcessingScreen),
  AutoRoute(path: '/confirmEmail', page: OnboardingScreen),
  AutoRoute(path: '/seedRecovery', page: SeedRecoveryScreen),
  AutoRoute(path: '/restoreExistingAccount', page: RestoreExistingAccountScreen),
  AutoRoute(path: '/setupOrImportNewAccountScreen', page: SetupOrImportNewAccountScreen),
  AutoRoute(
      path: '/main',
      name: 'MainRouter',
      page: MainPageHostScreen,
      children: [
        AutoRoute(path: '', page: HomeScreen),
        AutoRoute(path: 'search', page: SearchScreen),
        AutoRoute(path: 'notification', page: NotificationScreen),
        AutoRoute(path: 'settings', page: SettingsScreen),
        AutoRoute(path: 'message', page: MessageScreen),
      ]),
])
class $AppRouter {}
