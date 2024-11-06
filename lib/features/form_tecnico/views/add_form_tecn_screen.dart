import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/form_tecn_model.dart';
import '../providers/form_tecn_provider.dart';

class AddFormTecnScreen extends StatelessWidget {
  const AddFormTecnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final numeroSerieController = TextEditingController();
    final descripcionController = TextEditingController();
    final fotoUrlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Formulario Técnico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: numeroSerieController,
              decoration: const InputDecoration(labelText: 'Número de Serie'),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: fotoUrlController,
              decoration: const InputDecoration(labelText: 'Foto URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newFormTecn = FormTecn(
                  id: DateTime.now().toString(),
                  nombre: nombreController.text,
                  numeroSerie: numeroSerieController.text,
                  descripcion: descripcionController.text,
                  fotoUrl: fotoUrlController.text,
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
