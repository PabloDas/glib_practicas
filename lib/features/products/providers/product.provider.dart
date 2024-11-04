import 'package:flutter/material.dart';
import '../models/product.model.dart';
import '../services/product.service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  // Método para escuchar los cambios de productos en tiempo real
  void listenToProducts() {
    _productService.streamProducts().listen((products) {
      _products = products;
      notifyListeners();
    });
  }

  // Método para agregar un producto
  Future<void> addProduct(Product product) async {
    await _productService.addProduct(product);
  }

  // Método para eliminar un producto
  Future<void> deleteProduct(String id) async {
    await _productService.deleteProduct(id);
    notifyListeners();
  }

    // Método para actualizar un producto
  Future<void> updateProduct(Product updatedProduct) async {
    await _productService.updateProduct(updatedProduct);
    notifyListeners();
  }
}

