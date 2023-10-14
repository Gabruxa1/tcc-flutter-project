import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  bool _rememberMe = false;
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = _isDarkTheme
        ? ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color(0xFF1b1e23),
            primaryColor: Colors.white,
            switchTheme: SwitchThemeData(
              trackColor: MaterialStateProperty.all(Colors.blue),
              thumbColor: MaterialStateProperty.all(Colors.blue),
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.black,
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(Colors.white),
            ),
          );

    return Theme(
      data: themeData,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        value: _isDarkTheme,
                        activeTrackColor: Colors.blue,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.white.withOpacity(0.7),
                        onChanged: (value) {
                          setState(() {
                            _isDarkTheme = value;
                          });
                        },
                      ),
                      Icon(
                        _isDarkTheme ? Icons.nightlight_round : Icons.wb_sunny,
                        color: _isDarkTheme ? Colors.white : Colors.black,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Bem vindo novamente",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Informe o usuário",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Usuário'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu usuário';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value!,
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_username.isEmpty) {
                                  Navigator.pushNamed(
                                      context, '/registroPonto');
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    print('Usuário: $_username');
                                  }
                                }
                              },
                              child: Text('LOGIN'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                side: BorderSide(color: Colors.blue, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Text("Lembrar-Me"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
