class Clima {
  final double temperatura;
  final String descripcion;
  final double viento;

  Clima({required this.temperatura, required this.descripcion, required this.viento});

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      temperatura: json['main']['temp'].toDouble(),
      descripcion: json['weather'][0]['description'],
      viento: json['wind']['speed'].toDouble(),
    );
  }
}
