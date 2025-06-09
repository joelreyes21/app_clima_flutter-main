import 'dart:convert';
import 'package:http/http.dart' as http;
import 'clima_model.dart';

Future<Clima> obtenerDatosClimaticos() async {
  const apiKey = 'ab5216fa1f685d74a529809ab3628095'; 
  const ciudad = 'La Ceiba';
  const url = 'https://api.openweathermap.org/data/2.5/weather?q=$ciudad&appid=$apiKey&units=metric&lang=es';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Clima.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error al obtener el clima');
  }
}
 