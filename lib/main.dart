import 'package:app/screens/info/info_screen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

void main() async {
  await SharedPreferencesService.init();

  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        'infos': (context) => InfoScreen()
      },
      title: 'Mobx Test',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
