import 'package:flutter/material.dart';
import 'dart:async';
import 'clima_service.dart';
import 'clima_model.dart';

void main() => runApp(AppClima());

class AppClima extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App del Clima',
      home: ClimaPantalla(),
    );
  }
}

class ClimaPantalla extends StatefulWidget {
  @override
  _ClimaPantallaState createState() => _ClimaPantallaState();
}

class _ClimaPantallaState extends State<ClimaPantalla> {
  late Future<Clima> _futureClima;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _cargarClima();
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      _cargarClima();
    });
  }

  void _cargarClima() {
    setState(() {
      _futureClima = obtenerDatosClimaticos();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Tiempo Real'),
      ),
      body: Center(
        child: FutureBuilder<Clima>(
          future: _futureClima,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: \${snapshot.error}');
            } else if (snapshot.hasData) {
              final clima = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🌡️ Temperatura: ${clima.temperatura} °C', style: TextStyle(fontSize: 20)),
                  Text('🌤️ Clima: ${clima.descripcion}', style: TextStyle(fontSize: 20)),
                  Text('💨 Viento: ${clima.viento} km/h', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _cargarClima,
                    child: Text('Actualizar Manualmente'),
                  ),
                ],
              );
            } else {
              return Text('Sin datos disponibles.');
            }
          },
        ),
      ),
    );
  }
}
