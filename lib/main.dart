import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/services/auth/auth_service.dart';
import 'package:firstapp/views/login_view.dart';
import 'package:firstapp/views/notes_view.dart';
import 'package:firstapp/views/register_view.dart';
import 'package:firstapp/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LogInView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NoteView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NoteView();
              } else {
                devtools.log('Please verify your email address');
                return const VerifyEmailView();
              }
            } else {
              return const LogInView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
