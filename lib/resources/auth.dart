import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/resources/login_or_register.dart';
import 'package:projeto/resources/project_auth.dart';
import 'package:projeto/views/screens/homepage_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.projAuth});
  final ProjectAuth projAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // usuário ja esta logado
          if (snapshot.hasData) {
            return HomePage();
          }
          // usuario ainda nao logado
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
