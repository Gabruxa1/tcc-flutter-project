import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class RegistroPontoPage extends StatefulWidget {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 400, // Defina a altura desejada aqui
              child: CalendarCarousel(
                onDayPressed: (DateTime date, _) {
                  setState(() {
                    _selectedDate = date;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Data selecionada: ${date.toLocal()}"),
                  ));
                },
                weekendTextStyle: TextStyle(color: Colors.red),
                thisMonthDayBorderColor: Colors.grey,
                selectedDateTime: _selectedDate,
                todayButtonColor: Colors.blue,
                todayTextStyle: TextStyle(color: Colors.white),
                daysHaveCircularBorder: true,
              ),
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
