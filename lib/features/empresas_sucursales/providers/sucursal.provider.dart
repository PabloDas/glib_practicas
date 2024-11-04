import 'package:flutter/material.dart';

import '../models/sucursal.model.dart';
import '../services/sucursal.service.dart';

class SucursalProvider extends ChangeNotifier {
  List<Sucursal> _sucursales = [];
  final SucursalService _sucursalService = SucursalService();

  List<Sucursal> get sucursales => _sucursales;

  // Método para cargar sucursales desde la base de datos Firebase.
  Future<void> fetchSucursales() async {
    try {
      print('Intentando cargar sucursales...');
      _sucursales = await _sucursalService.getSucursales();
      print('Sucursales cargadas correctamente: $_sucursales');
      notifyListeners(); // Notifica a los widgets que dependen de este estado.
    } catch (e) {
      print('Error al cargar sucursales: $e');
    }
  }

// Método para agregar una nueva sucursal.
Future<void> addSucursal(Sucursal nuevaSucursal) async {
  // Agregamos la nueva sucursal y obtenemos su ID actualizado.
  await _sucursalService.addSucursal(nuevaSucursal);

  // Vuelve a obtener las sucursales de Firestore para que la lista esté actualizada.
  await fetchSucursales();
  
  // Notificamos a los listeners después de actualizar la lista.
  notifyListeners();
}

    // Actualizar una sucursal existente
  Future<void> updateSucursal(Sucursal sucursalActualizada) async {
    await _sucursalService.updateSucursal(sucursalActualizada);
    int index = _sucursales.indexWhere((sucursal) => sucursal.id == sucursalActualizada.id);
    if (index != -1) {
      _sucursales[index] = sucursalActualizada;
      notifyListeners();
    }
  }
  // Método para eliminar una sucursal.
  Future<void> deleteSucursal(String id) async {
    await _sucursalService.deleteSucursal(id);
    _sucursales.removeWhere((sucursal) => sucursal.id == id);
    notifyListeners();
  }
}
