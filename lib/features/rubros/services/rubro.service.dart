import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/rubro.model.dart';

class RubroService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los rubros desde Firebase Firestore.
  Future<List<Rubro>> getRubros() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('rubros').get();
      return snapshot.docs.map((doc) {
        return Rubro.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener rubros: $e');
    }
  }

  // Agregar un nuevo rubro a Firebase Firestore.
  Future<void> addRubro(Rubro rubro) async {
    try {
      DocumentReference docRef = await _firestore.collection('rubros').add(rubro.toMap());
      // Actualizamos el rubro con el ID generado por Firestore.
      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Error al agregar rubro: $e');
    }
  }

  // Eliminar un rubro de Firebase Firestore por su ID.
  Future<void> deleteRubro(String id) async {
    try {
      await _firestore.collection('rubros').doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar rubro: $e');
    }
  }

    // Actualizar un rubro en Firebase Firestore.
  Future<void> updateRubro(Rubro rubro) async {
    try {
      await _firestore.collection('rubros').doc(rubro.id).update(rubro.toMap());
    } catch (e) {
      throw Exception('Error al actualizar rubro: $e');
    }
  }
}

