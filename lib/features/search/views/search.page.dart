import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search.provider.dart';

class SearchPage extends StatelessWidget {
  // Controladores de los campos de textos
  final TextEditingController _rubroController = TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para "Rubro"
            TextField(
              controller: _rubroController,
              decoration: const InputDecoration(labelText: 'Rubro'),
            ),
            // Campo de texto para "Numero de Serie"
            TextField(
              controller: _numeroSerieController,
              decoration: const InputDecoration(labelText: 'Número de Serie'),
            ),
            // Campo de texto para "Descripción"
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),
            // Boton de búsqueda
            ElevatedButton(
              onPressed: () {
                // Verificar que al menis un campo tenga datos
                if (_rubroController.text.isEmpty &&
                    _numeroSerieController.text.isEmpty &&
                    _descripcionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Por favor, ingrese al menos un criterio de busqueda. '),
                    ),
                  );
                }
                // Llamada al proveedor para realizar la búsqueda
                context.read<SearchProvider>().search(
                      _rubroController.text,
                      _numeroSerieController.text,
                      _descripcionController.text,
                    );
                // Limpiar los campos de texto después de la búsqueda
                _rubroController.clear();
                _numeroSerieController.clear();
                _descripcionController.clear();
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height:16),
            // Indicador de carga y resultados de bússqueda
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, searchProvider, child){
                  // Mostrar un indicador de carga mientras se realizan la búsqueda
                  if (searchProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Verifica si hay resultado
                  if (searchProvider.searchResults.isEmpty) {
                    return const Center(child: Text('No se encontraron productos.'));
                  }
                  // Mostrar la lista de productos si hay resultados
                  return ListView.builder(
                    itemCount: searchProvider.searchResults.length,
                    itemBuilder: (context, index) {
                      final product = searchProvider.searchResults[index];
                      return ListTile(
                        title: Text(product.descripcion),
                        subtitle: Text(
                            'Rubro: ${product.rubro}, Nro. Serie: ${product.numeroSerie}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
