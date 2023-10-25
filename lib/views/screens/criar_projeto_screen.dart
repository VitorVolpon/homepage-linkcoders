import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/resources/project_auth.dart';
import 'package:projeto/resources/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto/utils/constants.dart';
import 'package:projeto/utils/utils.dart';
import 'package:projeto/views/screens/homepage_screen.dart';
import 'package:projeto/views/widgets/button.dart';
import 'package:projeto/views/widgets/text_input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CriarProjetoPage extends StatefulWidget {
  const CriarProjetoPage();

  @override
  _CriarProjetoScreenState createState() => _CriarProjetoScreenState();
}

class _CriarProjetoScreenState extends State<CriarProjetoPage> {
  String? imageUrl;
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final languageTextController1 = TextEditingController();
  final languageTextController2 = TextEditingController();
  final languageTextController3 = TextEditingController();
  final languageTextController4 = TextEditingController();
  File? _pickedImage;
  Uint8List? _imageBytes;
  final userUidString = FirebaseAuth.instance.currentUser!.uid;
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: AppConstants.whiteColor,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppConstants.whiteColor),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Center(
          child: Image.asset(
            'assets/images/logoLinkCoders.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Título do Projeto',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppConstants.whiteColor,
              ),
            ),
            MyTextField(
              obscureText: false,
              controller: titleTextController,
              hintText: "Título do Projeto:",
              prefixIcon: Icons.assignment,
              suffixIcon: null,
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Descrição do Projeto',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppConstants.whiteColor,
              ),
            ),
            TextField(
              controller: descriptionTextController,
              maxLines: null,
              style: const TextStyle(color: AppConstants.whiteColor),
              decoration: const InputDecoration(
                hintText: "Descrição do Projeto:",
                suffixIcon: null,
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Linguagens de Programação',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppConstants.whiteColor,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: MyTextField(
                      obscureText: false,
                      controller: languageTextController1,
                      hintText: "Linguagem 1:",
                      prefixIcon: Icons.language,
                      suffixIcon: null,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: MyTextField(
                      obscureText: false,
                      controller: languageTextController2,
                      hintText: "Linguagem 2:",
                      prefixIcon: Icons.language,
                      suffixIcon: null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: MyTextField(
                      obscureText: false,
                      controller: languageTextController3,
                      hintText: "Linguagem 3:",
                      prefixIcon: Icons.language,
                      suffixIcon: null,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: MyTextField(
                      obscureText: false,
                      controller: languageTextController4,
                      hintText: "Linguagem 4:",
                      prefixIcon: Icons.language,
                      suffixIcon: null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            MyButton(onTap: _handleImageUpload, text: "Selecionar Imagem"),
            const SizedBox(height: 10.0),
            Expanded(
              flex: 4,
              child: Container(
                  decoration: BoxDecoration(
                    color: AppConstants.blackColor,
                    border: Border.all(
                      color: AppConstants.greenColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image != null
                      ? Image.memory(
                          _image!,
                          fit: BoxFit.fill,
                        )
                      : const Icon(
                          Icons.add_a_photo,
                          color: AppConstants.greenColor,
                        )),
            ),
            MyButton(
              onTap: () {
                // ProjectAuth().createProject(
                //     _image!,
                //     [],
                //     titleTextController.text,
                //     descriptionTextController.text,
                //     [
                //       languageTextController1.text,
                //       languageTextController2.text,
                //       languageTextController3.text,
                //       languageTextController4.text
                //     ],
                //     userUidString,
                //     userEmail!);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              text: "Criar Projeto",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleImageUpload() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // Future<void> _createProject(
  //   String? imageUrl, // Remova a declaração deste parâmetro
  //   String projectTitle,
  //   String projectDescription,
  //   List<String> projectLanguages,
  //   String authorId,
  //   String author,
  // ) async {
  //   // Verifique se a URL da imagem não é nula ou vazia
  //   if (imageUrl != null && imageUrl.isNotEmpty) {
  //     try {
  //       // Agora, chame a função de upload de imagem, passando a URL
  //       await widget.projAuth.createProject(
  //         imageUrl,
  //         [],
  //         projectTitle,
  //         projectDescription,
  //         projectLanguages,
  //         authorId,
  //         author,
  //       );
  //     } catch (e) {
  //       print('Erro ao fazer upload da imagem: $e');
  //     }
  //   } else {
  //     print('A URL da imagem está ausente ou vazia!');
  //   }
  // }
}
