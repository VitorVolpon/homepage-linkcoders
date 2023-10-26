import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto/themes/constants.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const PostCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    // fetchCommentLen();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // final width = constraints.maxWidth;
        // final height = constraints.maxHeight;

        return ClipRRect(
          child: Container(
            width: 600,
            height: 700,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 1,
            ),
            child: buildPostContent(600, 700,context),
          ),
        );
      },
    );
  }

  Widget buildPostContent(double width, double height,BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        children: [
          buildUserInfo(width),
          Stack(
            children: [
              buildImageContent(width, height,context),
              Positioned(
                bottom: 0, // Coloque os botões na parte inferior
                right: 0, // Coloque os botões no canto inferior esquerdo
                child: buildImageButtons(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUserInfo(double width) {
    return Container(
      width: 600, // Defina a largura igual à largura do postcontent
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildAvatar(),
          buildUsername(),
          buildMoreOptions(),
        ],
      ),
    );
  }

  Widget buildAvatar() {
    return const CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(
        'https://picsum.photos/250?image=9',
      ),
    );
  }

  Widget buildUsername() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'edu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMoreOptions() {
    return IconButton(
      onPressed: () => {},
      icon: const Icon(Icons.more_vert_outlined),
      color: Colors.white,
    );
  }

  Widget buildImageContent(double width, double height,BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.network(
          "https://picsum.photos/250?image=9",
          // widget.data['imageFileUrl'] ,
          fit: BoxFit.fitHeight,
          height: 600,
          width: widthScreen <= AppConstants.tamanhoCelular ? widthScreen : 600,
        ),
        Positioned(
          child: buildProjectDescription(width, 400),
        ),
      ],
    );
  }

  Widget buildProjectDescription(double width, double height) {
    return Container(
      width: 600,
      height: 600,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${widget.data['titulo'].toUpperCase()}',
                style: (GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                  ),
                )),
              ),
            ),
            const SizedBox(height: 40), // Espaço entre o título e a descrição
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                ' ${widget.data['descricao']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Linguagens do Projeto: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildLanguagesTopics(widget.data['linguagens']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguagesTopics(List<dynamic> languages) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 6.0,
          alignment: WrapAlignment.center,
          children: languages.map((language) {
            return Row(
              children: [
                Icon(
                  getIconForLanguage(language),
                  size: 32,
                  color: Colors.green,
                ),
                const SizedBox(width: 10),
                Text(
                  language,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData getIconForLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'javascript':
        return Icons.code;
      case 'python':
        return Icons.code;
      case 'dart':
        return Icons.code;
      // Adicione mais casos conforme necessário para outras linguagens
      default:
        return Icons.code; // Ícone padrão para linguagens desconhecidas
    }
  }

  Widget buildImageButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // print(
            //   '${MediaQuery.of(context).size.width} e ${MediaQuery.of(context).size.height}');
          },
          color: Colors.white,
          iconSize: 50,
          icon: const Icon(Icons.message_outlined),
        ),
        IconButton(
          onPressed: () {},
          color: Colors.white,
          iconSize: 50,
          icon: const Icon(Icons.content_paste_outlined),
        ),
      ],
    );
  }
}
