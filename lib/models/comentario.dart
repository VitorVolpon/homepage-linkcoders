class Comentario {
  final String autorNome; // Nome do autor do comentário
  final String conteudo; // Conteúdo do comentário

  Comentario({
    required this.autorNome,
    required this.conteudo,
  });

  Map<String, dynamic> toJson() {
    return {
      'autorNome': autorNome,
      'conteudo': conteudo,
    };
  }
}
