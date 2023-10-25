import 'package:flutter/material.dart';
import 'package:projeto/resources/project_auth.dart';
import 'package:projeto/resources/user_auth.dart';
import 'package:projeto/views/screens/login_screen.dart';
import 'package:projeto/views/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister();
  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // valor inicial para mostrar a pagina login
  bool showLoginPage = true;
  // mudança entre paginas
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // logica para mostrar a pagina de login
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
        authService: UserAuth(),
      );
    } else {
      return RegisterPage(onTap: togglePages, authService: UserAuth());
    }
  }
}
