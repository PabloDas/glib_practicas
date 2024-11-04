// edit_sucursal_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sucursal.model.dart';
import '../providers/sucursal.provider.dart';

class EditSucursalScreen extends StatefulWidget {
  final Sucursal sucursal;

  const EditSucursalScreen({super.key, required this.sucursal});

  @override
  _EditSucursalScreenState createState() => _EditSucursalScreenState();
}

class _EditSucursalScreenState extends State<EditSucursalScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.sucursal.nombre);
    _direccionController = TextEditingController(text: widget.sucursal.direccion);
    _telefonoController = TextEditingController(text: widget.sucursal.telefono);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Sucursal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Ingresa el nombre' : null,
              ),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) => value!.isEmpty ? 'Ingresa la dirección' : null,
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) => value!.isEmpty ? 'Ingresa el teléfono' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final sucursalActualizada = Sucursal(
                      id: widget.sucursal.id,
                      empresaId: widget.sucursal.empresaId,
                      nombre: _nombreController.text,
                      direccion: _direccionController.text,
                      telefono: _telefonoController.text,
                    );
                    Provider.of<SucursalProvider>(context, listen: false)
                        .updateSucursal(sucursalActualizada);
                    Navigator.of(context).pop(); // Volver a la pantalla anterior
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
