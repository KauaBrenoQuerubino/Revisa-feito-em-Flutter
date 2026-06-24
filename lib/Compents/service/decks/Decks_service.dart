import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revisai/Compents/model/Deck.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DecksService {
    final FirebaseFirestore _db =
      FirebaseFirestore.instance;

    Future<void> salvarDeck(
        Deck deck
      ) async {

      await _db.collection('decks').add(
        deck.toMap(),
      );
    }

    Future<void> atualizarDeck(Deck deck) async {
      await _db
          .collection('decks')
          .doc(deck.id)
          .update(deck.toMap());
    }
  
    Future<List<Deck>> listarDecksDoUsuario(String idUsuario) async {


      final resultado = await _db
          .collection('decks')
          .where('idUsuario', isEqualTo: idUsuario)
          .get();

      

      print("Docs encontrados: ${resultado.docs.length}");

      return resultado.docs.map((doc) {
        print(doc.data());
        return Deck.fromMap(doc.id, doc.data());
      }).toList();

    }

    Future<List<Map<String, dynamic>>> gerarFlashcards(
        String conteudo,
        int quantidade,
    ) async {
      try {
        final response = await http.post(
          Uri.parse("http://127.0.0.1:8000/gerar-flashcards"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "conteudo": conteudo,
            "quantidade": quantidade,
          }),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);

          // 🔥 conversão segura
          return data
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        } else {
          throw Exception("Erro: ${response.statusCode}");
        }
      } catch (e) {
        print("❌ Erro na requisição: $e");
        return [];
      }
    }
}
