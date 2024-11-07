import 'package:cloud_firestore/cloud_firestore.dart';

class FormTecn {
  final String id;
  final String nameForm;
  final String numForm;
  final String nameTecnico;
  final String numCliente;
  final String status;
  final Timestamp createdAt;
  //final String fotoUrl;

  FormTecn({
    required this.id,
    required this.nameForm,
    required this.numForm,
    required this.nameTecnico,
    required this.numCliente,
    required this.status,
    required this.createdAt,
    //required this.fotoUrl,
  });

  // Crear un formulario desde un Map (Firestore)
  factory FormTecn.fromMap(Map<String, dynamic> map) {
    return FormTecn(
      id: map['id'] ?? '',  // Asegurar que el ID no sea null
      nameForm: map['nameForm'] ?? '',
      numForm: map['numForm'] ?? '',
      nameTecnico: map['nameTecnico'] ?? '',
      numCliente: map['numCliente'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt'] ?? '',
      //fotoUrl: map['fotoUrl'] ?? '',
    );
  }

  // Convertir un formulario a un Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameForm': nameForm,
      'numForm': numForm,
      'nameTecnico': nameTecnico,
      'numCliente': numCliente,
      'status': status,
      'createdAt': createdAt,
      //'fotoUrl': fotoUrl,
    };
  }
}

