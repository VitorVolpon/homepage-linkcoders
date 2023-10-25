import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/resources/project_auth.dart';
import 'package:projeto/resources/user_auth.dart';
import 'package:projeto/utils/constants.dart';
import 'package:projeto/views/screens/criar_projeto_screen.dart';
import 'package:projeto/views/screens/recuperar_senha_screen.dart';
import 'package:projeto/views/widgets/button.dart';
import 'package:projeto/views/widgets/text_input_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final UserAuth authService; // Importe a classe AuthService necessária.

  const LoginPage({
    Key? key,
    required this.onTap,
    required this.authService,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool _loading = false;
  String? errorMessage;
  void _onLoginButtonPressed() async {
    setState(() {
      _loading = true; // Mostrar o indicador de progresso
    });
    final email = emailTextController.text.trim();
    final password = passwordTextController.text.trim();

    try {
      final user =
          await widget.authService.signInWithEmailAndPassword(email, password);

      if (user == null) {
        setState(() {
          errorMessage =
              "Preencha o campo de email!"; // Atualize o estado com a mensagem de erro
        });
      }
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CriarProjetoPage(),
        ),
      );
    } catch (error) {
      if (error is FirebaseAuthException) {
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
    } finally {
      // delay de 1 segundo para o botao de carregamento
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _loading =
            false; // Ocultar o indicador de progresso, independentemente do resultado da autenticação
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
            children: [
              const SizedBox(
                height: 80,
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
              // email textfield
              MyTextField(
                controller: emailTextController,
                obscureText: false,
                hintText: "Email :",
                prefixIcon: Icons.email_outlined,
                suffixIcon: null,
              ),
              const SizedBox(
                height: 25,
              ),
              // password textfield
              MyPasswordField(
                controller: passwordTextController,
                hintText: "Senha :",
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Esqueceu a senha?",
                    style:
                        TextStyle(color: AppConstants.whiteColor, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecuperarSenhaPage(
                            authService: UserAuth(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Clique aqui!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.greenColor,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // sign in button
              MyButton(
                onTap: _loading ? null : _onLoginButtonPressed,
                text: "Entrar",
              ),
              // botao de carregamento
              if (_loading)
                const CircularProgressIndicator(
                  color: AppConstants.greenColor,
                  strokeWidth: 10,
                ),

              const SizedBox(
                height: 15,
              ),
              // Exiba a mensagem de erro
              if (!_loading)
                Text(errorMessage ?? "",
                    style: const TextStyle(
                      color: Colors.red,
                    )),
              // go to register page
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Não tem uma conta?",
                    style:
                        TextStyle(color: AppConstants.whiteColor, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Cadastre-se",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.greenColor,
                          fontSize: 20),
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
