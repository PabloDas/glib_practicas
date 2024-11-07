import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/form_tecn_model.dart';
import '../providers/form_tecn_provider.dart';

class EditFormTecnScreen extends StatefulWidget {
  final FormTecn formTecn;

  const EditFormTecnScreen({super.key, required this.formTecn});

  @override
  _EditFormTecnScreenState createState() => _EditFormTecnScreenState();
}

class _EditFormTecnScreenState extends State<EditFormTecnScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nameForm;
  late String _numForm;
  late String _nameTecnico;
  late String _numCliente;
  late String _status;
  late Timestamp _createdAt;
  //late String _fotoUrl;

  @override
  void initState() {
    super.initState();
    _nameForm = widget.formTecn.nameForm;
    _numForm = widget.formTecn.numForm;
    _nameTecnico = widget.formTecn.nameTecnico;
    _numCliente = widget.formTecn.numCliente;
    _status = widget.formTecn.status;
    _createdAt = widget.formTecn.createdAt;
    //_fotoUrl = widget.product.fotoUrl;
  }

  @override
  Widget build(BuildContext context) {
    final formTecnProvider = Provider.of<FormTecnProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Formulario Técnico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nameForm,
                decoration: const InputDecoration(labelText: 'Nombre del Formulario'),
                onSaved: (value) => _nameForm = value!,
              ),
              TextFormField(
                initialValue: _numForm,
                decoration: const InputDecoration(labelText: 'Número de Serie'),
                onSaved: (value) => _numForm = value!,
              ),
              TextFormField(
                initialValue: _nameTecnico,
                decoration: const InputDecoration(labelText: 'Nombre del Técnico'),
                onSaved: (value) => _nameTecnico = value!,
              ),
              TextFormField(
                initialValue: _numCliente,
                decoration: const InputDecoration(labelText: 'Numero de Cliente'),
                onSaved: (value) => _numCliente = value!,
              ),
              TextFormField(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Estado'),
                onSaved: (value) => _status = value!,
              ),
              TextFormField(
                initialValue: _createdAt.toDate().toString(),
                decoration: const InputDecoration(labelText: 'Fecha de Creación'),
                onSaved: (value) => _createdAt = Timestamp.fromDate(DateTime.parse(value!)),
              ),
              // TextFormField(
              //   initialValue: _fotoUrl,
              //   decoration: const InputDecoration(labelText: 'Foto URL'),
              //   onSaved: (value) => _fotoUrl = value!,
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedFormTecn = FormTecn(
                      id: widget.formTecn.id,
                      nameForm: _nameForm,
                      numForm: _numForm,
                      nameTecnico: _nameTecnico,
                      numCliente: _numCliente,
                      status: _status,
                      createdAt: _createdAt,
                      //fotoUrl: _fotoUrl,
                    );
                    formTecnProvider.updateFormTecn(updatedFormTecn);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
