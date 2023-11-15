import 'package:app/components/common/privacy_policy.dart';
import 'package:app/main.dart';
import 'package:app/services/validators_service.dart';
import 'package:flutter/material.dart';

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
      validator: ValidatorsService().userValidator,
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
      validator: ValidatorsService().passwordValidator,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            const PrivacyPolicy(),
          ]),
        ),
      ),
    );
  }
}
