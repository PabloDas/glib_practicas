import 'package:flutter/material.dart';
import '../models/rubro.model.dart';
import '../services/rubro.service.dart';

class RubroProvider extends ChangeNotifier {
  List<Rubro> _rubros = [];
  final RubroService _rubroService = RubroService();

  List<Rubro> get rubros => _rubros;

  // Método para cargar rubros desde Firebase Firestore.
  Future<void> fetchRubros() async {
    _rubros = await _rubroService.getRubros();
    notifyListeners(); // Notifica a los widgets que dependen de este estado.
  }

  // Método para agregar un nuevo rubro.
  Future<void> addRubro(Rubro nuevoRubro) async {
    await _rubroService.addRubro(nuevoRubro);
    await fetchRubros(); // Actualizar la lista después de agregar.
    notifyListeners();
  }

  // Método para eliminar un rubro.
  Future<void> deleteRubro(String id) async {
    await _rubroService.deleteRubro(id);
    await fetchRubros(); // Actualizar la lista después de eliminar.
    notifyListeners();
  }

  // Método para editar un rubro.
  Future<void> updateRubro(Rubro rubro) async {
    await _rubroService.updateRubro(rubro);
    await fetchRubros(); // Actualizar la lista después de editar.
    notifyListeners();
  }
}
