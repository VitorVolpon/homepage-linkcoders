class AppUser {
  String id;
  String username;
  String email;
  String? github;
  String? linkedin;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    this.github,
    this.linkedin,
  });

  // Construtor nomeado vazio

  // Método para converter AppUser em um mapa (para armazenamento no Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'github': github,
      'linkedin': linkedin,
    };
  }
}
