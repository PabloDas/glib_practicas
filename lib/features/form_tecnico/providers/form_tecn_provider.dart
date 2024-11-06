import 'package:flutter/material.dart';
import '../models/form_tecn_model.dart';
import '../services/form_tecn_service.dart';

class FormTecnProvider extends ChangeNotifier {
  final FormTecnService _formTecnService = FormTecnService();
  List<FormTecn> _formTecn = [];

  List<FormTecn> get formTecn => _formTecn;

  // Método para escuchar los cambios de productos en tiempo real
  void listenToFormTecn() {
    _formTecnService.streamFormTecn().listen((products) {
      _formTecn = products;
      notifyListeners();
    });
  }

  // Método para agregar un producto
  Future<void> addFormTecn(FormTecn product) async {
    await _formTecnService.addFormTecn(product);
  }

  // Método para eliminar un producto
  Future<void> deleteFormTecn(String id) async {
    await _formTecnService.deleteFormTecn(id);
    notifyListeners();
  }

    // Método para actualizar un producto
  Future<void> updateFormTecn(FormTecn updatedFormTecn) async {
    await _formTecnService.updateFormTecn(updatedFormTecn);
    notifyListeners();
  }
}