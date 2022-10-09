import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent email verification text. Please open it to verify your account "),
          const Text("If you haven't received yet, click below"),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text("Send email verification")),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text("Restart")),
        ],
      ),
    );
  }
}
