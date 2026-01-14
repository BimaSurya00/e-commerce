part of 'app_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: LoginPage.routePath,
    navigatorKey: _rootNavigatorKey,
    routes: [
      // Auth Routes
      GoRoute(
        path: LoginPage.routePath,
        name: LoginPage.routeName,
        pageBuilder: (context, state) => AppPageTransitions.slideFade(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RegisterPage.routePath,
        name: RegisterPage.routeName,
        pageBuilder: (context, state) => AppPageTransitions.slideFade(
          key: state.pageKey,
          child: const RegisterPage(),
        ),
      ),

      // Main App with Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BasePage(navigationShell: navigationShell),
        branches: [
          // Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HomePage.routePath,
                name: HomePage.routeName,
                pageBuilder: (context, state) => AppPageTransitions.fade(
                  key: state.pageKey,
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          // Shop Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ShopPage.routePath,
                name: ShopPage.routeName,
                pageBuilder: (context, state) => AppPageTransitions.fade(
                  key: state.pageKey,
                  child: const ShopPage(),
                ),
                routes: [
                  // Product Detail
                  GoRoute(
                    path: DetailProductPage.routePath,
                    name: DetailProductPage.routeName,
                    pageBuilder: (context, state) => AppPageTransitions.slideFade(
                      key: state.pageKey,
                      child: DetailProductPage(
                        productId: state.pathParameters['productId'] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ProfilePage.routePath,
                name: ProfilePage.routeName,
                pageBuilder: (context, state) => AppPageTransitions.fade(
                  key: state.pageKey,
                  child: const ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
