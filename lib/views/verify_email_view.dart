import 'package:firstapp/services/auth/bloc/auth_bloc.dart';
import 'package:firstapp/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerification(),
                    );
              },
              child: const Text("Send email verification")),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Restart")),
        ],
      ),
    );
  }
}
