class Deck {
  final String ?id;
  final String ?idUsuario;
  final String nome;
  final String titulo;
  final List<Map<String, String>> flashcards;

  Deck({required this.id, required this.nome, required this.titulo, required this.flashcards, this.idUsuario});
}
