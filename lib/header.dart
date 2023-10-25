import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
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
      actions: [
        PopupMenuButton<String>(
          icon: Icon(
            Icons.density_medium,
            color: Colors.white,
            size: 24.0,
          ),
          onSelected: (String choice) {
            if (choice == 'Option 1') {
            } else if (choice == 'Option 2') {}
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Option 1'),
              ),
              PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Option 2'),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
