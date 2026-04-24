import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_pages.dart';
import '../../features/auth/presentation/pages/register_pages.dart';
import '../../features/auth/presentation/pages/verify_email_pages.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/pages/login_pages.dart';
import 'guards/auth_guard.dart';

// sementara dashboard dummy
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("DASHBOARD")));
  }
}

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    verifyEmail: (_) => const VerifyEmailPage(),
    dashboard: (_) => const AuthGuard(child: DashboardPage()),
  };
}
