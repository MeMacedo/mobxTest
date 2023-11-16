class ValidatorsService {
  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Sua senha não pode ser vazia.';
    }
    final reg = RegExp(r'\W|_');

    if (reg.hasMatch(password)) {
      return 'Caracteres especiais não são permitidos.';
    }

    if (password.length < 2 || password.length > 20) {
      return 'Sua senha precisa ter entre 2 e 20 caracteres.';
    }
    if (password.endsWith(' ')) {
      return 'Sua senha não pode terminar com espaço.';
    }
    return null;
  }

  String? userValidator(String? user) {
    if (user == null || user.isEmpty) {
      return 'Seu login não pode ser vazio.';
    }
    if (user.length > 20) {
      return 'Seu login pode ter até 20 caracteres.';
    }
    if (user.endsWith(' ')) {
      return 'Seu login não pode terminar com espaço.';
    }
    return null;
  }
}
