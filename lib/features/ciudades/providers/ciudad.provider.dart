import 'package:flutter/material.dart';
import '../models/ciudad.model.dart';
import '../services/ciudad.service.dart';

class CiudadProvider extends ChangeNotifier {
  List<Ciudad> _ciudades = [];
  final CiudadService _ciudadService = CiudadService();

  List<Ciudad> get ciudades => _ciudades;

  // Método para cargar ciudades desde Firestore.
  Future<void> fetchCiudades() async {
    _ciudades = await _ciudadService.getCiudades();
    notifyListeners(); // Notifica a los widgets que dependen de este estado.
  }

  // Método para agregar una nueva ciudad.
  Future<void> addCiudad(Ciudad nuevaCiudad) async {
    await _ciudadService.addCiudad(nuevaCiudad);
    await fetchCiudades();  // Actualizar la lista después de agregar.
    notifyListeners();
  }

    // Método para modificar una ciudad existente.
  Future<void> updateCiudad(Ciudad ciudadActualizada) async {
    await _ciudadService.updateCiudad(ciudadActualizada);
    await fetchCiudades();  // Actualizar la lista después de modificar.
    notifyListeners();
  }

  // Método para eliminar una ciudad.
  Future<void> deleteCiudad(String id) async {
    await _ciudadService.deleteCiudad(id);
    await fetchCiudades();  // Actualizar la lista después de eliminar.
    notifyListeners();
  }
}
