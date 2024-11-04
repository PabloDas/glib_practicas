import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ciudad.model.dart';
import '../providers/ciudad.provider.dart';

class EditCiudadScreen extends StatefulWidget {
  final Ciudad ciudad;

  const EditCiudadScreen({super.key, required this.ciudad});

  @override
  _EditCiudadScreenState createState() => _EditCiudadScreenState();
}

class _EditCiudadScreenState extends State<EditCiudadScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;

  @override
  void initState() {
    super.initState();
    _nombre = widget.ciudad.nombre;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final ciudadActualizada = Ciudad(
        id: widget.ciudad.id, // Mantenemos el ID existente.
        nombre: _nombre,
      );

      Provider.of<CiudadProvider>(context, listen: false).updateCiudad(ciudadActualizada);
      Navigator.of(context).pop(); // Volver a la pantalla anterior.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Ciudad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre de la Ciudad'),
                onSaved: (value) => _nombre = value!,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa el nombre de la ciudad' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
