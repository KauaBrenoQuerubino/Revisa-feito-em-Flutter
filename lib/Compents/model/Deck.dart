import 'dart:convert';

class Deck {
  String ?id;
  String ?idUsuario;
  String titulo;
  List<Map<String, String>> flashcards;

  Deck({
    this.id, 
    required this.idUsuario,
    required this.titulo, 
    required this.flashcards 
    });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'titulo': titulo,
      'flashcards': flashcards,
    };
  }

  factory Deck.fromMap(String id, Map<String, dynamic> map) {
    List flashcardsRaw;

    if (map['flashcards'] is String) {
      flashcardsRaw = jsonDecode(map['flashcards']);
    } else {
      flashcardsRaw = map['flashcards'] ?? [];
    }

    return Deck(
      id: id,
      titulo: map['titulo'] ?? '',
      idUsuario: map['idUsuario'] ?? '',
      flashcards: flashcardsRaw
          .map((item) => Map<String, String>.from(item))
          .toList(),
    );

  }

}
