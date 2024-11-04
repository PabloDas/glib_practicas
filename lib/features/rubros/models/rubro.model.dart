class Rubro {
  final String id;
  final String nombre;

  Rubro({
    required this.id,
    required this.nombre,
  });

  // Convertir un mapa en un objeto Rubro.
  factory Rubro.fromMap(Map<String, dynamic> data) {
    return Rubro(
      id: data['id'],
      nombre: data['nombre'],
    );
  }

  // Convertir un objeto Rubro en un mapa.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
