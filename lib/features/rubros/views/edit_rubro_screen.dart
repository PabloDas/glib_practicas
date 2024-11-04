// edit_rubro_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rubro.model.dart';
import '../providers/rubro.provider.dart';

class EditRubroScreen extends StatefulWidget {
  final Rubro rubro; // Recibe el rubro a editar.

  const EditRubroScreen({required this.rubro, super.key});

  @override
  _EditRubroScreenState createState() => _EditRubroScreenState();
}

class _EditRubroScreenState extends State<EditRubroScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;  // Para almacenar el nombre actualizado.

  @override
  void initState() {
    super.initState();
    _nombre = widget.rubro.nombre;  // Inicializar con el nombre actual.
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final rubroEditado = Rubro(
        id: widget.rubro.id,  // Usamos el mismo ID.
        nombre: _nombre,      // Nuevo nombre.
      );

      // Actualizamos el rubro.
      Provider.of<RubroProvider>(context, listen: false).updateRubro(rubroEditado);
      Navigator.of(context).pop(); // Volvemos a la pantalla anterior.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Rubro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre del Rubro'),
                onSaved: (value) => _nombre = value!,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre válido' : null,
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


