import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: RegistroPontoPage(toggleTheme: _toggleTheme),
    );
  }
}

class RegistroPontoPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  RegistroPontoPage({required this.toggleTheme});

  @override
  _RegistroPontoPageState createState() => _RegistroPontoPageState();
}

class _RegistroPontoPageState extends State<RegistroPontoPage> {
  DateTime? _selectedDate;
  List<DateTime> _pontosRegistrados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Ponto"),
        actions: [
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              widget.toggleTheme(); // Chama o callback para mudar o tema
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CalendarCarousel(
              locale: 'pt_BR',
              onDayPressed: (DateTime date, _) {
                setState(() {
                  _selectedDate = date;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Data selecionada: ${date.day}/${date.month}/${date.year}"),
                ));
              },
              weekendTextStyle: TextStyle(color: Colors.red),
              thisMonthDayBorderColor: Colors.grey,
              selectedDateTime: _selectedDate,
              todayButtonColor: Colors.blue,
              todayTextStyle: TextStyle(color: Colors.white),
              daysHaveCircularBorder: true,
            ),
            ElevatedButton(
              child: Text("Registrar Ponto"),
              onPressed: () {
                if (!_pontosRegistrados.contains(DateTime.now())) {
                  _pontosRegistrados.add(DateTime.now());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Ponto registrado!"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Ponto já registrado para hoje!"),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
