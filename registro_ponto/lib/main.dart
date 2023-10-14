// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/registro_ponto/registro_ponto_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/registroPonto': (context) => RegistroPontoPage(),
        // ... outras rotas
      },
      title: 'Aplicativo de Ponto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
