import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/form_tecn_model.dart';
import '../providers/form_tecn_provider.dart';

class AddFormTecnScreen extends StatelessWidget {
  const AddFormTecnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameFormController = TextEditingController();
    final numFormController = TextEditingController();
    final nameTecnicoController = TextEditingController();
    final numClienteController = TextEditingController();
    final statusController = TextEditingController();
    final createdAtController = TextEditingController();
    //final fotoUrlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Formulario Técnico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameFormController,
              decoration: const InputDecoration(labelText: 'Nombre de Formulario'),
            ),
            TextField(
              controller: numFormController,
              decoration: const InputDecoration(labelText: 'Número de Formulario'),
            ),
            TextField(
              controller: nameTecnicoController,
              decoration: const InputDecoration(labelText: 'Nombre del Técnico'),
            ),
            TextField(
              controller: numClienteController,
              decoration: const InputDecoration(labelText: 'Numero de Cliente'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            TextField(
              controller: createdAtController,
              decoration: const InputDecoration(labelText: 'Fecha de Creación'),
            ),
           // TextField(
           //   controller: fotoUrlController,
           //   decoration: const InputDecoration(labelText: 'Foto URL'),
           // ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newFormTecn = FormTecn(
                  id: DateTime.now().toString(),
                  nameForm: nameFormController.text,
                  numForm: numFormController.text,
                  nameTecnico: nameTecnicoController.text,
                  numCliente: numClienteController.text,
                  status: statusController.text,
                  createdAt: Timestamp.fromDate(DateTime.now()),
                  //fotoUrl: fotoUrlController.text,
                );

                Provider.of<FormTecnProvider>(context, listen: false)
                    .addFormTecn(newFormTecn);

                Navigator.of(context).pop();
              },
              child: const Text('Agregar Formulario Técnico'),
            ),
          ],
        ),
      ),
    );
  }
}
