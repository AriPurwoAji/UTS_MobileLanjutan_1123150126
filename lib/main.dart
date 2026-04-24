import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'core/routes/guards/auth_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // 🔥 ENTRY POINT
        home: const SplashPage(),

        // OPTIONAL ROUTES
        routes: {
    '/home': (context) => const AuthGuard(
          child: Scaffold(
            body: Center(child: Text("HOME PAGE")),
          ),
        ),
  },
      ),
    );
  }
}