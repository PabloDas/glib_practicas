import 'package:flutter/material.dart';
import 'package:glib_practicas/features/form_tecnico/providers/form_tecn_provider.dart';
import 'package:provider/provider.dart';
import 'add_form_tecn_screen.dart';
import 'edit_form_tecn_screen.dart';

class FormTecnScreen extends StatelessWidget {
  const FormTecnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<FormTecnProvider>(context);

    // Escuchar productos en tiempo real
    productProvider.listenToFormTecn();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Técnico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla para agregar un nuevo formulario técnico
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddFormTecnScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<FormTecnProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.formTecn.isEmpty) {
            return const Center(child: Text('No hay productos registrados'));
          }

          return ListView.builder(
            itemCount: FormTecnProvider().formTecn.length,
            itemBuilder: (context, index) {
              final product = FormTecnProvider().formTecn[index];
              return ListTile(
                leading: SizedBox(
                  width: 50.0, // Define un tamaño para la imagen
                  height: 50.0,
                  child: product.fotoUrl.isNotEmpty
                      ? Image.network(product.fotoUrl, fit: BoxFit.cover)
                      : const Icon(Icons.image), // Ícono si no hay imagen
                ),
                title: Text(product.nombre),
                subtitle: Text('Nro. Serie: ${product.numeroSerie}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navegar a la pantalla para editar el formulario técnico
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditFormTecnScreen(product: product),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        productProvider.deleteFormTecn(product.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
