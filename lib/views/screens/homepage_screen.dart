import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/responsve/responsive_layout.dart';
import 'package:projeto/views/widgets/postcard.dart';
import 'package:projeto/header.dart';
import 'package:projeto/resources/project_auth.dart'; // Importe a classe que contém o método getAllProjects

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppHeader(),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          // Usando o método getAllProjects para buscar todos os projetos
          future: ProjectAuth().getAllProjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar projetos: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('Nenhum projeto encontrado.'),
              );
            }

            final projects = snapshot.data!;
            for (int i = 0; i < projects.length; i++) {
              print(projects[i]);
            }

            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    child: PostCard(
                      data: projects[index],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
