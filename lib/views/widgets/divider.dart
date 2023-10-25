import 'package:flutter/material.dart';
import 'package:projeto/utils/constants.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 5, // Altura da linha
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppConstants.whiteColor,
            AppConstants.greenColor
          ], // Gradiente de cores
          begin: Alignment.centerLeft, // Início do gradiente à esquerda
          end: Alignment.centerRight, // Fim do gradiente à direita
        ),
        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
      ),
    );
  }
}
