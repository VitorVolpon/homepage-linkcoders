import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/resources/storage_methods.dart';
import 'package:projeto/models/post.dart';
import 'package:projeto/models/comentario.dart';

class ProjectAuth {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createProject(
    Uint8List imageFile,
    List<Comentario> comentarios,
    List<String> membros,
    String projectTitle,
    String projectDescription,
    List<String> projectLanguage,
    String autor,
    String autorId,
    List<String> categoria,
  ) async {
    final _user = FirebaseAuth.instance.currentUser;
    String imageUrl =
        await StorageMethods().uploadImageToStorage('ProjectLogo', imageFile);
    DateTime _now = DateTime.now();

    if (_user != null) {
      final authorId = _user.uid;

      // Referência para a coleção 'projects' no Firestore
      final projectsCollection =
          FirebaseFirestore.instance.collection('projects');

      // Dados do projeto, incluindo a URL da imagem e o authorId
      final projeto = Projeto(
          imageFileUrl: imageUrl,
          autorId: authorId,
          autor: autor,
          titulo: projectTitle,
          descricao: projectDescription,
          dataCriacao: _now,
          linguagens: projectLanguage,
          comentarios: comentarios,
          membros: membros,
          categoria: categoria);

      // Adicione o documento do projeto ao Firestore com ID gerado automaticamente
      DocumentReference documentReference =
          await projectsCollection.add(projeto.toJson());

      // Obtenha o ID gerado automaticamente pelo Firestore
      String projectId = documentReference.id;

      // Atualize o documento com o campo "id" usando o ID gerado
      await documentReference.update({'id': projectId});

      // Resto do código para criar o projeto...
    } else {
      print('Nenhum usuário autenticado.');
    }
  }

  Future<List<Map<String, dynamic>>> fetchProjects(String uid) async {
    final firestore = FirebaseFirestore.instance;
    // Consulta projetos onde o campo 'autorId' corresponde ao UID fornecido
    final QuerySnapshot querySnapshot = await firestore
        .collection('projects')
        .where('autorId', isEqualTo: uid)
        .get();

    List<Map<String, dynamic>> projects = [];

    querySnapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      projects.add(data);
    });
    return projects;
  }

  Future<List<Map<String, dynamic>>> fetchUserMemberProjects(
      String userId) async {
    final projectsRef = _firestore.collection('projects');
    final querySnapshot =
        await projectsRef.where('members', arrayContains: userId).get();

    final projects = querySnapshot.docs.map((doc) => doc.data()).toList();
    return projects;
  }

// Função para buscar os usuários de um projeto
  Future<List<String>> getUsersInProject(String projectId) async {
    List<String> usersInProject = [];

    // Consulta o documento do projeto
    DocumentSnapshot projectSnapshot = await FirebaseFirestore.instance
        .collection('projetos')
        .doc(projectId)
        .get();

    // Verifica se o documento do projeto existe
    if (projectSnapshot.exists) {
      // Obtém os UIDs dos membros do projeto
      List<dynamic> memberUIDs = projectSnapshot['membros'];

      // Consulta os documentos de usuários com base nos UIDs
      for (String uid in memberUIDs) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .get();

        // Verifica se o documento do usuário existe
        if (userSnapshot.exists) {
          // Adiciona o UID do usuário à lista de usuários no projeto
          usersInProject.add(uid);
        }
      }
    }

    return usersInProject;
  }

  Future<Map<String, dynamic>?> getProjectDocument(String projectUid) async {
    final projectDoc = await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectUid)
        .get();
    return projectDoc.data();
  }

  Future<List<Map<String, dynamic>>> getAllProjects() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Consulta a coleção 'projects' para obter todos os documentos
      final QuerySnapshot querySnapshot =
          await firestore.collection('projects').get();

      List<Map<String, dynamic>> projects = [];

      querySnapshot.docs.forEach((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        projects.add(data);
      });

      return projects;
    } catch (error) {
      print('Erro ao buscar projetos: $error');
      return [];
    }
  }
}
