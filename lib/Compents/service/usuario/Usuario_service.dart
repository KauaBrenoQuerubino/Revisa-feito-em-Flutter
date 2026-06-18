import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revisai/Compents/model/Usuario.dart';

class UsuarioService {

  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  Future<void> salvarUsuario(
    Usuario usuario,
  ) async {

    await _db.collection('usuarios').add(
      usuario.toMap(),
    );
  }

  Future<Usuario?> buscarPorEmail(
    String email,
  ) async {

    final resultado = await _db
        .collection('usuarios')
        .where(
          'email',
          isEqualTo: email,
        )
        .limit(1)
        .get();

    if (resultado.docs.isEmpty) {
      return null;
    }

    final doc = resultado.docs.first;

    return Usuario.fromMap(
      doc.id,
      doc.data(),
    );
  }

  Future<List<Usuario>> listarUsuarios()
  async {

    final resultado =
        await _db.collection('usuarios').get();

    return resultado.docs.map((doc) {

      return Usuario.fromMap(
        doc.id,
        doc.data(),
      );

    }).toList();
  }
}