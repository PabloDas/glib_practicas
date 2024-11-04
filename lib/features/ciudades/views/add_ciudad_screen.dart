import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ciudad.model.dart';
import '../providers/ciudad.provider.dart';

class AddCiudadScreen extends StatefulWidget {
  const AddCiudadScreen({super.key});

  @override
  _AddCiudadScreenState createState() => _AddCiudadScreenState();
}

class _AddCiudadScreenState extends State<AddCiudadScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final nuevaCiudad = Ciudad(
        id: '', // El ID será generado por Firestore.
        nombre: _nombre,
      );

      Provider.of<CiudadProvider>(context, listen: false).addCiudad(nuevaCiudad);
      Navigator.of(context).pop(); // Volver a la pantalla anterior.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Ciudad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre de la Ciudad'),
                onSaved: (value) => _nombre = value!,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa el nombre de la ciudad' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Ciudad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
