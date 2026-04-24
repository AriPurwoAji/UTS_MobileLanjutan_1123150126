import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_providers.dart';
import 'verify_email_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.loginWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (success) {
      if (!mounted) return;

      // pindah ke dashboard
      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (!mounted) return;

      if (authProvider.status == AuthStatus.emailNotVerified) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const VerifyEmailPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login gagal'),
          ),
        );
      }
    }
  }

  Future<void> _handleGoogleLogin() async {
    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.loginWithGoogle();

    if (success) {
      if (!mounted) return;

      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Google login gagal'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // EMAIL
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email wajib diisi';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // PASSWORD
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // LOGIN BUTTON
                  authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _handleLogin,
                          child: const Text("Login"),
                        ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // GOOGLE LOGIN
            ElevatedButton(
              onPressed: _handleGoogleLogin,
              child: const Text("Login dengan Google"),
            ),
          ],
        ),
      ),
    );
  }
}