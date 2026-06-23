import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revisai/Compents/model/Deck.dart';

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

      print(idUsuario);

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

}
