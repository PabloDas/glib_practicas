import '../models/product.model.dart';

class SearchService {
  final List<Product> _products = [
    // Lista de producto de ej , podria agregar desde una API o Bases de Datos
    Product(
        id: '1',
        rubro: 'Electronica',
        numeroSerie: '12345',
        descripcion: 'Televisor 40 pulgadas'),
    Product(
        id: '2',
        rubro: 'Hogar',
        numeroSerie: '67890',
        descripcion: 'Refrigerador 350L'),
  ];
  List<Product> searchProducts(
      {String? rubro, String? numeroSerie, String? descripcion}) {
    return _products.where((product) {
      final matchesRubro = rubro == null ||
          product.rubro.toLowerCase().contains(rubro.toLowerCase());
      final matchesNumeroSerie =
          numeroSerie == null || product.numeroSerie.contains(numeroSerie);
      final matchesDescripcion = descripcion == null ||
          product.descripcion.toLowerCase().contains(descripcion.toLowerCase());

      return matchesRubro && matchesNumeroSerie && matchesDescripcion;
    }).toList();
  }
}
