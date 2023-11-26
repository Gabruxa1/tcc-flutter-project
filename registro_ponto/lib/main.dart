import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/registro_ponto/registro_ponto_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginPage(), // Rota padrão para a página de login
        '/registroPonto': (context) => RegistroPontoPage(
              toggleTheme: () {},
            ),
        // ... outras rotas que você possa adicionar
      },
      title: 'Aplicativo de Ponto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Define a rota inicial do seu aplicativo
    );
  }
}
