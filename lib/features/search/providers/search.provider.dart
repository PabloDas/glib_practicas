
import 'package:flutter/material.dart';
import '../models/product.model.dart';

class SearchProvider extends ChangeNotifier {
  List<Product> _searchResults = [];
  bool _isLoading = false;

  List<Product> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  // Simulacion de búsqueda
  void search(String rubro, String numeroSerie, String descripcion) async {
    _isLoading = true;
    notifyListeners();
    // Simular un delay de búsqueda (puede ser llamada a base de datos o API)
    await Future.delayed(const Duration(seconds: 2));

    // aqui deberia ir la lógica de búsqueda
    _searchResults = [
      // Simulacion de producto encontrado
      Product(
        id: '1',
        rubro: rubro.isNotEmpty ? rubro : 'RubroX',
        numeroSerie: numeroSerie.isNotEmpty ? numeroSerie : '12345',
        descripcion:
            descripcion.isNotEmpty ? descripcion : 'Descripcion de producto',
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }
}
