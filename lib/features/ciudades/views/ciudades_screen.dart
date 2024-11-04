import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ciudad.provider.dart';
import 'add_ciudad_screen.dart';
import 'edit_ciudad_screen.dart';

class CiudadesScreen extends StatelessWidget {
  const CiudadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ciudadProvider = Provider.of<CiudadProvider>(context);

    // Llamamos a fetchCiudades para cargar las ciudades cuando la pantalla se inicializa.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ciudadProvider.fetchCiudades();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciudades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddCiudadScreen()),
              );
            },
          ),
        ],
      ),
      body: ciudadProvider.ciudades.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ciudadProvider.ciudades.length,
              itemBuilder: (context, index) {
                final ciudad = ciudadProvider.ciudades[index];
                return ListTile(
                  title: Text(ciudad.nombre),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditCiudadScreen(ciudad: ciudad),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ciudadProvider.deleteCiudad(ciudad.id);
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
