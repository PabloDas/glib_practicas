import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sucursal.model.dart';
import '../providers/sucursal.provider.dart';

class AddSucursalScreen extends StatefulWidget {
  const AddSucursalScreen({super.key});

  @override
  _AddSucursalScreenState createState() => _AddSucursalScreenState();
}

class _AddSucursalScreenState extends State<AddSucursalScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _direccion = '';
  String _telefono = '';
  String _empresaId = ''; // Aquí puedes asignar un ID de empresa real si lo tienes.

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final nuevaSucursal = Sucursal(
        id: '', // El ID lo genera Firestore.
        empresaId: _empresaId,
        nombre: _nombre,
        direccion: _direccion,
        telefono: _telefono,
      );

      Provider.of<SucursalProvider>(context, listen: false).addSucursal(nuevaSucursal);
      Navigator.of(context).pop(); // Volver a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Sucursal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _nombre = value!,
                validator: (value) => value!.isEmpty ? 'Ingresa el nombre' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => _direccion = value!,
                validator: (value) => value!.isEmpty ? 'Ingresa la dirección' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Teléfono'),
                onSaved: (value) => _telefono = value!,
                validator: (value) => value!.isEmpty ? 'Ingresa el teléfono' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Sucursal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
