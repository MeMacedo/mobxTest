import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Sua senha não pode ser vazia.';
  }
  final reg = RegExp(r'/\W|_/');

  if (reg.hasMatch(password)) {
    return 'Caracteres especiais não são permitidos.';
  }

  if (password.length < 2 || password.length > 20) {
    return 'Sua senha precisa ter entr 2 e 20 caracteres.';
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

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextFormField _getUserName() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Usuário',
        prefixIcon: Icon(Icons.person),
      ),
      validator: userValidator,
    );
  }

  TextFormField _getUserPassword() {
    return TextFormField(
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        labelText: 'Senha',
        prefixIcon: Icon(Icons.lock_rounded),
      ),
      validator: passwordValidator,
    );
  }

  ElevatedButton _getLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          navigatorKey.currentState!.pushNamed('infos');
        }
      },
      child: const Text(
        'Entrar',
      ),
    );
  }

  TextButton _getPrivacyPolicy() {
    final url = Uri.parse('https://www.google.com');

    return TextButton(
      onPressed: () {
        launchUrl(url);
      },
      child: const Text(
        'Politica de Privacidade',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.teal,
          Colors.blue,
        ],
      )),
      child: Form(
        key: _formKey,
        child: Column(children: [
          _getUserName(),
          _getUserPassword(),
          _getLoginButton(),
          _getPrivacyPolicy(),
        ]),
      ),
    );
  }
}
