import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/form_tecn_model.dart';

class FormTecnService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obtener formularios
  // Stream<List<FormTecn>> streamFormTecn() {
  //   return _firestore.collection('formTech').snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return FormTecn.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

 // Obtener todas los formularios desde Firebase Firestore.
  Future<List<FormTecn>> getFormTech() async {
    try {
      debugPrint("Obteniendo formularios desde Firestore...");
      QuerySnapshot snapshot = await _firestore.collection('formTech').get();
      debugPrint("Número de formularios obtenidos: ${snapshot.docs.length}");

      return snapshot.docs.map((doc) {
        debugPrint("Formulario obtenido: ${doc.data()}");
        return FormTecn.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint("Error al obtener formularios: $e");
      throw Exception('Error al obtener sucursales: $e');
    }
  }


  // Agregar un nuevo formularios a Firestore.
  Future<void> addFormTecn(FormTecn formTech) async {
    try {
      await _firestore.collection('formTech').add(formTech.toMap());
    } catch (e) {
      throw Exception('Error al agregar formulario: $e');
    }
  }

  // Eliminar un formularios de Firestore.
  Future<void> deleteFormTecn(String id) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('formTech')
          .where('id', isEqualTo: id)
          .get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('formTech').doc(doc.id).delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar formulario: $e');
    }
  }

  // Actualizar un formulario existente en Firestore
  Future<void> updateFormTecn(FormTecn formTecn) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('formTech')
          .where('id', isEqualTo: formTecn.id)
          .get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('formTech').doc(doc.id).update(formTecn.toMap());
      }
    } catch (e) {
      throw Exception('Error al actualizar formulario: $e');
    }
  }
}

