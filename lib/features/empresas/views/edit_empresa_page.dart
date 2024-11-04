// edit_empresa_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/empresa.model.dart';
import '../providers/empresa.provider.dart';

class EditEmpresaPage extends StatefulWidget {
  final Empresa empresa;

  const EditEmpresaPage({super.key, required this.empresa});

  @override
  _EditEmpresaPageState createState() => _EditEmpresaPageState();
}

class _EditEmpresaPageState extends State<EditEmpresaPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.empresa.nombre);
    _direccionController = TextEditingController(text: widget.empresa.direccion);
    _telefonoController = TextEditingController(text: widget.empresa.telefono);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Empresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la dirección';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final empresaActualizada = Empresa(
                      id: widget.empresa.id,
                      nombre: _nombreController.text,
                      direccion: _direccionController.text,
                      telefono: _telefonoController.text,
                    );

                    // Actualiza la empresa a través del provider
                    Provider.of<EmpresaProvider>(context, listen: false)
                        .updateEmpresa(empresaActualizada);

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }
}
