import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sucursal.model.dart';

class SucursalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todas las sucursales desde Firebase Firestore.
  Future<List<Sucursal>> getSucursales() async {
    try {
      print("Obteniendo sucursales desde Firestore...");
      QuerySnapshot snapshot = await _firestore.collection('sucursales').get();
      print("Número de documentos obtenidos: ${snapshot.docs.length}");

      return snapshot.docs.map((doc) {
        print("Documento obtenido: ${doc.data()}");
        return Sucursal.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error al obtener sucursales: $e");
      throw Exception('Error al obtener sucursales: $e');
    }
  }

// Agregar una nueva sucursal a Firebase Firestore.
Future<void> addSucursal(Sucursal sucursal) async {
  try {
    // Añadimos el documento a Firestore y obtenemos la referencia al documento.
    DocumentReference docRef = await _firestore.collection('sucursales').add(sucursal.toMap());
    
    // Ahora actualizamos el objeto Sucursal con el ID generado por Firestore.
    await docRef.update({'id': docRef.id});
    
  } catch (e) {
    throw Exception('Error al agregar sucursal: $e');
  }
}

    // Actualizar una sucursal
  Future<void> updateSucursal(Sucursal sucursal) async {
    try {
      await _firestore.collection('sucursales').doc(sucursal.id).update(sucursal.toMap());
    } catch (e) {
      throw Exception('Error al actualizar sucursal: $e');
    }
  }

  // Eliminar una sucursal de Firebase Firestore por su ID.
  Future<void> deleteSucursal(String id) async {
    try {
      await _firestore.collection('sucursales').doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar sucursal: $e');
    }
  }
}
