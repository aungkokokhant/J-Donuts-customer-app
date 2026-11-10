import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/data/local_auth_repository.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/auth/presentation/auth_flow_page.dart';
import '../features/auth/presentation/onboarding_page.dart';
import '../features/auth/presentation/session_controller.dart';
import '../features/cart/presentation/cart_page.dart';
import '../features/home/presentation/home_landing_page.dart';
import '../features/product/presentation/product_detail_page.dart';
import '../features/product/presentation/product_preview.dart';
import '../features/rewards/presentation/rewards_page.dart';
import '../l10n/app_localizations.dart';
import 'app_shell.dart';
import 'repository_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => LocalAuthRepository(
    ref.watch(databaseProvider),
    const FlutterSecureStorage(),
  ),
);

final appRouterProvider = Provider<GoRouter>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final session = SessionController(repository);
  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: session,
    redirect: (context, state) => _redirect(state, session),
    routes: [
      GoRoute(path: '/', builder: (_, _) => const OnboardingPage()),
      GoRoute(
        path: '/session',
        builder: (_, _) => _SessionPage(session: session),
      ),
      GoRoute(
        path: '/auth',
        builder: (_, state) => AuthFlowPage(
          mode: state.uri.queryParameters['mode'] == 'login'
              ? AuthMode.login
              : AuthMode.register,
          repository: repository,
          session: session,
        ),
      ),
      ShellRoute(
        builder: (_, state, child) =>
            AppShell(location: state.uri.path, session: session, child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: HomeLandingPage(memberName: session.user?.firstName),
            ),
          ),
          GoRoute(
            path: '/rewards',
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: const RewardsPage(),
            ),
          ),
          GoRoute(
            path: '/cart',
            builder: (_, _) {
              final user = session.user;
              return user == null
                  ? const SizedBox.shrink()
                  : CartPage(key: ValueKey(user.phone), owner: user.phone);
            },
          ),
          GoRoute(
            path: '/product/:id',
            builder: (_, state) {
              final user = session.user;
              if (user == null) return const SizedBox.shrink();
              return ProductDetailPage(
                id: state.pathParameters['id']!,
                cartOwner: user.phone,
                preview: state.extra is ProductPreview
                    ? state.extra as ProductPreview
                    : null,
              );
            },
          ),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    session.dispose();
  });
  unawaited(session.restore());
  return router;
});

String? _redirect(GoRouterState state, SessionController session) {
  final location = state.matchedLocation;
  if (session.loading || session.failed) {
    return location == '/session' ? null : '/session';
  }
  if (location == '/session') return session.user == null ? '/' : '/home';
  if ((location == '/home' ||
          location == '/rewards' ||
          location == '/cart' ||
          state.fullPath == '/product/:id') &&
      session.user == null) {
    return '/';
  }
  if ((location == '/' || location == '/auth') && session.user != null) {
    return '/home';
  }
  return null;
}

class _SessionPage extends StatelessWidget {
  const _SessionPage({required this.session});
  final SessionController session;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ListenableBuilder(
        listenable: session,
        builder: (context, _) => session.failed
            ? TextButton(
                onPressed: session.restore,
                child: Text(AppLocalizations.of(context).authError),
              )
            : const CircularProgressIndicator(),
      ),
    ),
  );
}
