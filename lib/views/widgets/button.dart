import 'package:flutter/material.dart';
import 'package:projeto/utils/constants.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: 24),
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  color: AppConstants.blackColor,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
