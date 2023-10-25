import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto/resources/auth.dart';
import 'package:projeto/resources/login_or_register.dart';
import 'package:projeto/resources/project_auth.dart';
import 'package:projeto/resources/user_auth.dart';
import 'package:projeto/firebase_options.dart';
import 'package:projeto/views/screens/criar_projeto_screen.dart';
import 'package:projeto/views/screens/homepage_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    projectAuth: ProjectAuth(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.projectAuth});
  final ProjectAuth projectAuth;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LinkCoders',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ignore: prefer_const_constructors
      home: HomePage(),
    );
  }
}
