import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rubro.model.dart';
import '../providers/rubro.provider.dart';

class AddRubroScreen extends StatefulWidget {
  const AddRubroScreen({super.key});

  @override
  _AddRubroScreenState createState() => _AddRubroScreenState();
}

class _AddRubroScreenState extends State<AddRubroScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final nuevoRubro = Rubro(
        id: '', // El ID será generado por Firestore.
        nombre: _nombre,
      );

      Provider.of<RubroProvider>(context, listen: false).addRubro(nuevoRubro);
      Navigator.of(context).pop(); // Vuelve a la pantalla anterior.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Rubro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre del Rubro'),
                onSaved: (value) => _nombre = value!,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa el nombre del rubro' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Rubro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
