import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_providers.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi Email")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80),
            const SizedBox(height: 20),

            const Text(
              "Kami telah mengirim email verifikasi.\nSilakan cek inbox kamu.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // BUTTON CEK VERIFIKASI
            authProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final success = await context
                          .read<AuthProvider>()
                          .checkEmailVerification();

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Email berhasil diverifikasi")),
                        );

                        // pindah ke dashboard
                        // Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    child: const Text("Saya sudah verifikasi"),
                  ),

            const SizedBox(height: 10),

            // RESEND EMAIL
            TextButton(
              onPressed: () async {
                await context
                    .read<AuthProvider>()
                    .resendVerificationEmail();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Email dikirim ulang")),
                );
              },
              child: const Text("Kirim ulang email"),
            ),

            const SizedBox(height: 20),

            // ERROR MESSAGE
            if (authProvider.errorMessage != null)
              Text(
                authProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}