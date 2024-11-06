import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/form_tecn_model.dart';

class FormTecnService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obtener productos como un stream en tiempo real
  Stream<List<FormTecn>> streamFormTecn() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FormTecn.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Agregar un nuevo producto a Firestore.
  Future<void> addFormTecn(FormTecn product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
    } catch (e) {
      throw Exception('Error al agregar formulario: $e');
    }
  }

  // Eliminar un producto de Firestore.
  Future<void> deleteFormTecn(String id) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('id', isEqualTo: id)
          .get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('products').doc(doc.id).delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar formulario: $e');
    }
  }

  // Actualizar un producto existente en Firestore
  Future<void> updateFormTecn(FormTecn product) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('id', isEqualTo: product.id)
          .get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('formTecn').doc(doc.id).update(product.toMap());
      }
    } catch (e) {
      throw Exception('Error al actualizar formulario: $e');
    }
  }
}

