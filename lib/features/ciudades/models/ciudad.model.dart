class Ciudad {
  final String id;
  final String nombre;

  Ciudad({
    required this.id,
    required this.nombre,
  });

  // Convertir un mapa en un objeto Ciudad.
  factory Ciudad.fromMap(Map<String, dynamic> data) {
    return Ciudad(
      id: data['id'],
      nombre: data['nombre'],
    );
  }

  // Convertir un objeto Ciudad en un mapa.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
