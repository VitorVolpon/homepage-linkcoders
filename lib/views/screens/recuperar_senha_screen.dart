import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/resources/login_or_register.dart';
import 'package:projeto/resources/project_auth.dart';
import 'package:projeto/resources/user_auth.dart';
import 'package:projeto/utils/constants.dart';
import 'package:projeto/views/widgets/button.dart';
import 'package:projeto/views/widgets/text_input_field.dart';

class RecuperarSenhaPage extends StatefulWidget {
  final UserAuth authService; // Importe a classe AuthService necessária.
  const RecuperarSenhaPage({Key? key, required this.authService})
      : super(key: key);
  @override
  State<RecuperarSenhaPage> createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? errorMessage;
  void onTapRecuperar() async {
    final email = emailTextController.text;

    try {
      await widget.authService.passwordReset(email);

      // Após a recuperação bem-sucedida, navegue de volta para a tela de login
      // ignore: use_build_context_synchronously
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const LoginOrRegister(),
      //   ),
      // );
    } catch (error) {
      if (error is FirebaseAuthException) {
        print(error);
        final errorCode = error.code;
        final errorMessage = widget.authService.errorCodeMessage(errorCode);
        setState(() {
          this.errorMessage =
              errorMessage; // Atualize o estado com a mensagem de erro
        });
      } else {
        setState(() {
          errorMessage = "Erro ao fazer login. Verifique suas credenciais.";
        });
      }
    }
  }

  void onTapVoltar() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginOrRegister(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: onTapVoltar,
                      icon: const Icon(
                        Icons.close_outlined,
                        color: AppConstants.greenColor,
                        size: 40,
                      ))
                ],
              ),

              const SizedBox(
                height: 60,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logoLinkCoders.png',
                  width: 300,
                  height: 300,
                ),
              ),
              // logo
              const SizedBox(
                height: 10,
              ),
              //recovery email textfield
              MyTextField(
                controller: emailTextController,
                obscureText: false,
                hintText: "Email de Recuperação",
                prefixIcon: Icons.email_outlined,
                suffixIcon: null,
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(onTap: onTapRecuperar, text: "Recuperar"),
              Text(errorMessage ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
