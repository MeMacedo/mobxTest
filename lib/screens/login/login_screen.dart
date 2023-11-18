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
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Padding(
          padding: EdgeInsets.only(bottom: 24, left: 8),
          child: Text(
            'Usuário',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        prefixIcon: Icon(Icons.person),
      ),
      validator: ValidatorsService().userValidator,
    );
  }

  TextFormField _getUserPassword() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        label: Padding(
          padding: EdgeInsets.only(bottom: 24, left: 8),
          child: Text(
            'Senha',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        prefixIcon: Icon(
          Icons.lock_rounded,
        ),
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
            Radius.circular(20),
          ),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          navigatorKey.currentState!.pushNamed('infos');
        }
      },
      child: const SizedBox(
        width: 80,
        child: Text(
          'Entrar',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: _getUserName(),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _getUserPassword()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _getLoginButton(),
            ),
            const Spacer(),
            const PrivacyPolicy(),
          ]),
        ),
      ),
    );
  }
}
