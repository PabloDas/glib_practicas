import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/empresa.model.dart';

class EmpresaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todas las empresas
  Future<List<Empresa>> getEmpresas() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('empresas').get();
      return snapshot.docs.map((doc) {
        return Empresa.fromMap({
          'id': doc.id, // Usar el ID del documento de Firebase
          ...doc.data() as Map<String, dynamic>
        });
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener empresas: $e');
    }
  }

  // Agregar una nueva empresa
  Future<void> addEmpresa(Empresa empresa) async {
    try {
      await _firestore.collection('empresas').add(empresa.toMap());
    } catch (e) {
      throw Exception('Error al agregar empresa: $e');
    }
  }

  // Eliminar una empresa
  Future<void> deleteEmpresa(String id) async {
    try {
      await _firestore.collection('empresas').doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar empresa: $e');
    }
  }
  // Actualizar una empresa
  Future<void> updateEmpresa(Empresa empresa) async {
    try {
      await _firestore.collection('empresas').doc(empresa.id).update(empresa.toMap());
    } catch (e) {
      throw Exception('Error al actualizar empresa: $e');
    }
  }
}
