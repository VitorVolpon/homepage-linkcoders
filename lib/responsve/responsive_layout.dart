import 'package:flutter/material.dart';
import 'package:projeto/themes/constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.blackColor, // Define a cor de fundo preto
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1000,
            maxHeight: 1000 // Largura máxima de 600 pixels
          ),
          child: child,
        ),
      ),
    );
  }
}