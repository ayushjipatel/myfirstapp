import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/services/auth/bloc/auth_bloc.dart';
import 'package:firstapp/services/auth/bloc/auth_event.dart';
import 'package:firstapp/services/auth/bloc/auth_state.dart';
import 'package:firstapp/services/auth/firebase_auth_provider.dart';
import 'package:firstapp/views/login_view.dart';
import 'package:firstapp/views/notes/create_update_note_view.dart';
import 'package:firstapp/views/notes/notes_view.dart';
import 'package:firstapp/views/register_view.dart';
import 'package:firstapp/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LogInView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NoteView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NoteView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LogInView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
