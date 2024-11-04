class Empresa {
  final String id;
  final String nombre;
  final String direccion;
  final String telefono;

  Empresa({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.telefono,
  });

  // Convertir un mapa (Firestore data) en un objeto Empresa
  factory Empresa.fromMap(Map<String, dynamic> data) {
    return Empresa(
      id: data['id'],
      nombre: data['nombre'],
      direccion: data['direccion'],
      telefono: data['telefono'],
    );
  }

  // Convertir un objeto Empresa en un mapa para almacenar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
