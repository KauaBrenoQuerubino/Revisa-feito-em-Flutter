import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revisai/Compents/model/Usuario.dart';
import 'package:revisai/Compents/service/usuario/Usuario_service.dart';

class AuthService {

  final UsuarioService service = 
      UsuarioService();

  Future<Usuario?> login(String email, String senha) async {
    Usuario? usuario = await service.buscarPorEmail(email);

    if(usuario == null) {
      
      throw Exception("usuario nao encontrado");
    }

    if(usuario.senha != senha) {
      throw Exception("credenciais invalidas");
    }

    return usuario;
  }

}