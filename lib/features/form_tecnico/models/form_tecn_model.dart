class FormTecn {
  final String id;
  final String nombre;
  final String numeroSerie;
  final String descripcion;
  final String fotoUrl;

  FormTecn({
    required this.id,
    required this.nombre,
    required this.numeroSerie,
    required this.descripcion,
    required this.fotoUrl,
  });

  // Crear un producto desde un Map (Firestore)
  factory FormTecn.fromMap(Map<String, dynamic> map) {
    return FormTecn(
      id: map['id'] ?? '',  // Asegurar que el ID no sea null
      nombre: map['nombre'] ?? '',
      numeroSerie: map['numeroSerie'] ?? '',
      descripcion: map['descripcion'] ?? '',
      fotoUrl: map['fotoUrl'] ?? '',
    );
  }

  // Convertir un producto a un Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'numeroSerie': numeroSerie,
      'descripcion': descripcion,
      'fotoUrl': fotoUrl,
    };
  }
}

