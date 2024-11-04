import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sucursal.provider.dart';
import 'add_sucursal_screen.dart';
import 'edit_sucursal_screen.dart';

class SucursalesScreen extends StatelessWidget {
  const SucursalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sucursalProvider = Provider.of<SucursalProvider>(context);

    // Llama a fetchSucursales cuando la pantalla se carga por primera vez.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sucursalProvider.fetchSucursales();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucursales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddSucursalScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: sucursalProvider.sucursales.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: sucursalProvider.sucursales.length,
              itemBuilder: (context, index) {
                final sucursal = sucursalProvider.sucursales[index];
                return ListTile(
                  title: Text(sucursal.nombre),
                  subtitle: Text(sucursal.direccion),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditSucursalScreen(sucursal: sucursal),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          sucursalProvider.deleteSucursal(sucursal.id);
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

