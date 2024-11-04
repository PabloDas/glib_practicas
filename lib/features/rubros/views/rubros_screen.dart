import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rubro.provider.dart';
import 'add_rubro_screen.dart';
import 'edit_rubro_screen.dart';

class RubrosScreen extends StatelessWidget {
  const RubrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rubroProvider = Provider.of<RubroProvider>(context);

    // Llamar a fetchRubros cuando la pantalla se carga por primera vez.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rubroProvider.fetchRubros();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rubros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddRubroScreen()),
              );
            },
          ),
        ],
      ),
      body: rubroProvider.rubros.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: rubroProvider.rubros.length,
              itemBuilder: (context, index) {
                final rubro = rubroProvider.rubros[index];
                return ListTile(
                  title: Text(rubro.nombre),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navegamos a la pantalla de edición con el rubro seleccionado.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditRubroScreen(rubro: rubro),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          rubroProvider.deleteRubro(rubro.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
