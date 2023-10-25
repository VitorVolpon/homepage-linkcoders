import 'package:flutter/material.dart';
import 'package:projeto/utils/constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator; // Adicione um validador

  const MyTextField({
    Key? key,
    required this.obscureText,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.validator,
    this.controller, // Aceite um validador opcional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        // Substitua TextField por TextFormField
        controller: controller,
        style: const TextStyle(color: AppConstants.whiteColor),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: AppConstants.greenColor,
            size: 20,
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: AppConstants.greenColor,
            size: 15,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          alignLabelWithHint: true,
        ),
        validator: validator, // Adicione o validador aqui
      ),
    );
  }
}

class MyPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const MyPasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        // Substitua TextField por TextFormField
        controller: widget.controller,
        obscureText: _obscureText,
        style: const TextStyle(color: AppConstants.whiteColor),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          prefixIcon: const Icon(
            Icons.key_outlined,
            color: AppConstants.greenColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppConstants.greenColor,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
