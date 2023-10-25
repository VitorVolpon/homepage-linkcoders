import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/resources/user_auth.dart';
import 'package:projeto/utils/constants.dart';
import 'package:projeto/views/widgets/button.dart';

import 'package:projeto/views/widgets/text_input_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  final UserAuth authService;
  const RegisterPage(
      {super.key, required this.onTap, required this.authService});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final userAuth = UserAuth();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  String? errorMessage;

  void _onSubmitButtonPressed() async {
    final email = emailTextController.text.trim();
    final password = passwordTextController.text.trim();
    final confirmPassword = confirmPasswordTextController.text.trim();
    final username = usernameTextController.text.trim();
    final usernameExist = await userAuth.isUsernameTaken(username);
    final senhasIguais = password == confirmPassword;
    final validUsername = username.length > 3;
    final validPassword = userAuth.isStrongPassword(password);
    if (senhasIguais && validUsername && !usernameExist && validPassword) {
      // Crie o usuário no Firebase usando seu serviço UserAuth
      try {
        final user = await widget.authService.createUserWithEmailAndPassword(
          email,
          password,
          usernameTextController.text,
          '',
          '',
        );
      } catch (error) {
        if (error is FirebaseAuthException) {
          final errorCode = error.code;
          final errorMessage = widget.authService.errorCodeMessage(errorCode);

          setState(() {
            this.errorMessage = errorMessage;
          });
        } else if (!validUsername) {
          setState(() {
            errorMessage = 'O nome de usuário deve ter no mínimo 4 caracteres';
          });
        } else {
          setState(() {
            errorMessage = "Erro inesperado. Tente novamente mais tarde.";
          });
        }
      }
    } else if (usernameExist) {
      setState(() {
        errorMessage = 'O nome de usuário já está em uso. Escolha outro.';
      });
    } else if (!validPassword) {
      setState(() {
        errorMessage =
            'A senha deve ter no mínimo 8 caracteres, incluindo pelo menos uma letra maiúscula e um número';
      });
    } else {
      setState(() {
        errorMessage = "Senhas não coincidem! Tente novamente.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Center(
                  child: Image.asset(
                'assets/images/logoLinkCoders.png',
                width: 300,
                height: 150,
              )),
              // logo
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: usernameTextController,
                obscureText: false,
                hintText: "Username :",
                prefixIcon: Icons.email_outlined,
                suffixIcon: null,
              ),
              const SizedBox(
                height: 15,
              ),
              // email textfield
              MyTextField(
                obscureText: false,
                controller: emailTextController,
                hintText: "Email :",
                prefixIcon: Icons.email_outlined,
                suffixIcon: null,
              ),
              const SizedBox(
                height: 15,
              ),
              // password textfield
              MyPasswordField(
                controller: passwordTextController,
                hintText: "Senha :",
              ),
              const SizedBox(
                height: 15,
              ),
              // confirm password textfield
              MyTextField(
                obscureText: true,
                controller: confirmPasswordTextController,
                hintText: "Confirmar Senha :",
                prefixIcon: Icons.key_outlined,
                suffixIcon: null,
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 15,
              ),
              // sign in button
              MyButton(onTap: _onSubmitButtonPressed, text: "Criar Conta"),
              const SizedBox(
                height: 20,
              ),
              Text(errorMessage ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                  )),
              // go to register page
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " Tem uma conta? ",
                    style: TextStyle(
                      color: AppConstants.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Conecte-se",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstants.greenColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
