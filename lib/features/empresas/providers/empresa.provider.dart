import 'package:flutter/material.dart';
import '../models/empresa.model.dart';
import '../services/empresa.service.dart';

class EmpresaProvider extends ChangeNotifier {
  List<Empresa> _empresas = [];
  final EmpresaService _empresaService = EmpresaService();

  List<Empresa> get empresas => _empresas;

  // Método para cargar empresas desde la base de datos.
  Future<void> fetchEmpresas() async {
    try {
      _empresas = await _empresaService.getEmpresas();
      print('Empresas cargadas correctamente: $_empresas');
      notifyListeners();
    } catch (e) {
      print('Error al cargar empresas: $e');
    }
  }

  // Método para agregar una nueva empresa
  Future<void> addEmpresa(Empresa nuevaEmpresa) async {
    await _empresaService.addEmpresa(nuevaEmpresa);
    _empresas.add(nuevaEmpresa);
    notifyListeners();
  }

  // Método para eliminar una empresa
  Future<void> deleteEmpresa(String id) async {
    await _empresaService.deleteEmpresa(id);
    _empresas.removeWhere((empresa) => empresa.id == id);
    notifyListeners();
  }
    // Actualizar una empresa
  Future<void> updateEmpresa(Empresa empresaActualizada) async {
    await _empresaService.updateEmpresa(empresaActualizada);
    int index = _empresas.indexWhere((empresa) => empresa.id == empresaActualizada.id);
    if (index != -1) {
      _empresas[index] = empresaActualizada;
      notifyListeners();
    }
  }
}
