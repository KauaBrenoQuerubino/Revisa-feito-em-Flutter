class Usuario {
  String? id;
  String nome;
  String email;
  String senha;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  factory Usuario.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Usuario(
      id: id,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      senha: map['senha'] ?? '',
    );
  }
}