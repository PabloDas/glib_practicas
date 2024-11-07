import 'package:flutter/material.dart';
import '../models/form_tecn_model.dart';
import '../services/form_tecn_service.dart';

class FormTecnProvider extends ChangeNotifier {
  final FormTecnService _formTecnService = FormTecnService();
  List<FormTecn> _formTecn = [];
  
  List<FormTecn> get formTecn => _formTecn;

  // Método para escuchar los cambios de formularios en tiempo real
  // void listenToFormTecn() {
  //   _formTecnService.getFormTech().listen((_formTecn) {
  //     _formTecn = formTecn;
  //     notifyListeners();
  //   });
  // }

   // Método para cargar formularios desde la base de datos Firebase.
   Future<void> fetchFormTecn() async {
    try {
      debugPrint('Intentando cargar formularios...');
      _formTecn = await _formTecnService.getFormTech();
      debugPrint('Formularios cargadas correctamente: $_formTecn');
      notifyListeners(); // Notifica a los widgets que dependen de este estado.
    } catch (e) {
      debugPrint('Error al cargar formularios: $e');
    }
  }



  // Método para agregar un formulario técnico
  Future<void> addFormTecn(FormTecn formTecn) async {
    await _formTecnService.addFormTecn(formTecn);
  }

  // Método para eliminar un formulario técnico
  Future<void> deleteFormTecn(String id) async {
    await _formTecnService.deleteFormTecn(id);
    notifyListeners();
  }

    // Método para actualizar un formulario técnico
  Future<void> updateFormTecn(FormTecn updatedFormTecn) async {
    await _formTecnService.updateFormTecn(updatedFormTecn);
    notifyListeners();
  }
}