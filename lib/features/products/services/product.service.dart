import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obtener productos como un stream en tiempo real
  Stream<List<Product>> streamProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data());
      }).toList();
    });
  }

  // Agregar un nuevo producto a Firestore.
  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
    } catch (e) {
      throw Exception('Error al agregar producto: $e');
    }
  }

  // Eliminar un producto de Firestore.
  Future<void> deleteProduct(String id) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('id', isEqualTo: id)
          .get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('products').doc(doc.id).delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar producto: $e');
    }
  }

  // Actualizar un producto existente en Firestore
  Future<void> updateProduct(Product product) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('id', isEqualTo: product.id)
          .get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('products').doc(doc.id).update(product.toMap());
      }
    } catch (e) {
      throw Exception('Error al actualizar producto: $e');
    }
  }
}

