class Sucursal {
  final String id;
  final String empresaId; // ID de la empresa a la que pertenece
  final String nombre;
  final String direccion;
  final String telefono;

  Sucursal({
    required this.id,
    required this.empresaId,
    required this.nombre,
    required this.direccion,
    required this.telefono,
  });

  // Convertir un mapa en un objeto Sucursal.
  factory Sucursal.fromMap(Map<String, dynamic> data) {
    return Sucursal(
      id: data['id'],
      empresaId: data['empresaId'],
      nombre: data['nombre'],
      direccion: data['direccion'],
      telefono: data['telefono'],
    );
  }

  // Convertir un objeto Sucursal en un mapa.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'empresaId': empresaId,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
