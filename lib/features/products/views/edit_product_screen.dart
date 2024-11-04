import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.model.dart';
import '../providers/product.provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _numeroSerie;
  late String _descripcion;
  late String _fotoUrl;

  @override
  void initState() {
    super.initState();
    _nombre = widget.product.nombre;
    _numeroSerie = widget.product.numeroSerie;
    _descripcion = widget.product.descripcion;
    _fotoUrl = widget.product.fotoUrl;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _nombre = value!,
              ),
              TextFormField(
                initialValue: _numeroSerie,
                decoration: const InputDecoration(labelText: 'Número de Serie'),
                onSaved: (value) => _numeroSerie = value!,
              ),
              TextFormField(
                initialValue: _descripcion,
                decoration: const InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => _descripcion = value!,
              ),
              TextFormField(
                initialValue: _fotoUrl,
                decoration: const InputDecoration(labelText: 'Foto URL'),
                onSaved: (value) => _fotoUrl = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedProduct = Product(
                      id: widget.product.id,
                      nombre: _nombre,
                      numeroSerie: _numeroSerie,
                      descripcion: _descripcion,
                      fotoUrl: _fotoUrl,
                    );
                    productProvider.updateProduct(updatedProduct);
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
