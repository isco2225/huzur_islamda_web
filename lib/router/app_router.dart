import 'package:go_router/go_router.dart';

import '../screens/delete_account_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/privacy_policy_screen.dart';
import '../screens/terms_of_use_screen.dart';

// String normalizePath(Uri uri) {
//   if (!uri.hasScheme) {
//     return uri.toString();
//   }
//   if (uri.path.isEmpty) {
//     return uri.toString();
//   }
//   return uri.toString().replaceAll('//', '/').replaceAll('\\', '/');
// }

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
    GoRoute(
      path: '/privacy_policy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: '/terms_of_use',
      builder: (context, state) => const TermsOfUseScreen(),
    ),
    GoRoute(
      path: '/delete_account',
      builder: (context, state) => const DeleteAccountScreen(),
    ),
  ],
);
