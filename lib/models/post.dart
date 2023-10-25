import 'package:projeto/models/comentario.dart';

class Projeto {
  final String autor;
  final String autorId;
  final String titulo;
  final String descricao;
  final List<String> membros;
  final String imageFileUrl;
  final DateTime dataCriacao;
  final List<String> linguagens;
  final List<String>
      categoria; // Campo para armazenar as linguagens selecionadas
  final List<Comentario> comentarios; // Campo para armazenar os comentários

  Projeto({
    required this.imageFileUrl,
    required this.autorId,
    required this.autor,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.linguagens, // Lista de linguagens selecionadas
    required this.comentarios,
    required this.categoria,
    required this.membros, // Lista de comentários
  });

  Map<String, dynamic> toJson() {
    return {
      'autor': autor,
      'imageFileUrl': imageFileUrl,
      'titulo': titulo,
      'descricao': descricao,
      'autorId': autorId,
      'dataCriacao': dataCriacao.toUtc().toIso8601String(),
      'linguagens': linguagens, // Inclua as linguagens no JSON
      'comentarios':
          comentarios.map((comentario) => comentario.toJson()).toList(),
      'categoria': categoria // Inclua os comentários no JSON
    };
  }
}
