import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: Colors.green.shade400,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade800),
              currentAccountPicture: ClipOval(
                // image de perfil
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWb80O40L-wQ3JMvHG8_afRsCEc6w2FUVdtA&usqp=CAU'),
              ),
              // nome do usuário
              accountName: const Text('Neymar',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // email do usuário
              accountEmail: const Text('neymar.jr@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          buildTile('Meus Projetos', Icons.shopping_bag_outlined, () {}),
          buildTile('Mensagens',  Icons.email_outlined, () {} ),
          buildTile('Novo Projeto', Icons.add_circle_outline, () {}),
          buildTile('Editar Perfil', Icons.person, () {}),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Sair', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            iconColor: Colors.black,
            textColor: Colors.black,
            onTap: (){},
          ),
        ],
      ),
    );
  }
}

Widget buildTile(String tileText, IconData tileIcon, Function()?onTap) {
  return  ListTile(
    leading: Icon(tileIcon),
    title: Text(tileText, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    iconColor: Colors.white,
    textColor: Colors.white,
    onTap: onTap,
  );
}