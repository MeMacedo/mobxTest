import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
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
}
