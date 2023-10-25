import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/models/post.dart';
import 'package:projeto/models/user.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = result.user;
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isStrongPassword(String password) {
    // Pelo menos 8 caracteres, incluindo pelo menos uma letra maiúscula.
    final pattern = r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  String errorCodeMessage(String errorCode) {
    switch (errorCode) {
      case 'wrong-password':
        return 'Senha incorreta. Tente novamente.';
      case 'missing-password':
        return 'Informe a senha. Tente novamente';
      case 'invalid-email':
        return 'Formato inválido de email. Tente novamente.';
      case 'user-not-found':
        return 'Usuário não encontrado. Verifique seu email.';
      case 'user-disabled':
        return 'Esta conta de usuário foi desativada.';
      case 'weak-password':
        return 'Senha fraca. Escolha uma senha mais forte.';
      case 'email-already-in-use':
        return 'O email já está em uso. Tente fazer login ou recuperar sua senha.';
      // Adicione mais casos conforme necessário para outros códigos de erro.
      default:
        return 'Erro de autenticação: $errorCode';
    }
  }

  Future<bool> doesEmailExist(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      // Se methods não estiver vazio, isso significa que o email já está em uso.
      // Caso contrário, o email está disponível.
      return methods.isNotEmpty;
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante a verificação
      return false; // Por precaução, retorne false em caso de erro
    }
  }

  Future<bool> isUsernameTaken(String username) async {
    final querySnapshot = await _firestore
        .collection('usuarios')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password,
      String username, String github, String linkedin) async {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      final newUser = AppUser(
        id: userCredential.user!.uid,
        username: username,
        email: email,
        github: github,
        linkedin: linkedin,
      );

      // Armazene os dados do usuário no Firestore usando o UID como identificador do documento
      await _firestore
          .collection('usuarios')
          .doc(newUser.id)
          .set(newUser.toJson());
      print(userCredential.user);
      return userCredential.user;
    }
  }

  Future passwordReset(String email) async {
    return await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  
}
