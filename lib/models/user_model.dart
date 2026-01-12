class UserModel {
  final String name;
  final String cpf;
  final String? email; 

  UserModel({
    required this.name,
    required this.cpf,
    this.email,
  });

  // Método para converter para JSON (para salvar)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cpf': cpf,
      'email': email,
    };
  }

  // Construtor para criar de JSON (para carregar)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      cpf: json['cpf'],
      email: json['email'],
    );
  }

  // Exemplo de hardcoded (para mock/testes)
  static UserModel getUserTeste() {
    return UserModel(
      name: 'Usuario de Teste',
      cpf: '11111111111',
      email: 'teste@gmail.com',
    );
  }
}