import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ciudad.model.dart';

class CiudadService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todas las ciudades desde Firestore.
  Future<List<Ciudad>> getCiudades() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('ciudades').get();
      return snapshot.docs.map((doc) {
        return Ciudad.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener ciudades: $e');
    }
  }

  // Agregar una nueva ciudad a Firestore.
  Future<void> addCiudad(Ciudad ciudad) async {
    try {
      DocumentReference docRef = await _firestore.collection('ciudades').add(ciudad.toMap());
      await docRef.update({'id': docRef.id}); // Actualizamos el ID generado por Firestore.
    } catch (e) {
      throw Exception('Error al agregar ciudad: $e');
    }
  }

    // Modificar una ciudad existente en Firestore.
  Future<void> updateCiudad(Ciudad ciudad) async {
    try {
      await _firestore.collection('ciudades').doc(ciudad.id).update(ciudad.toMap());
    } catch (e) {
      throw Exception('Error al modificar ciudad: $e');
    }
  }

  // Eliminar una ciudad de Firestore por su ID.
  Future<void> deleteCiudad(String id) async {
    try {
      await _firestore.collection('ciudades').doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar ciudad: $e');
    }
  }
}
