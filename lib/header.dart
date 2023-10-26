import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      title: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logoLinkcoders.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.home,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 24.0,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
