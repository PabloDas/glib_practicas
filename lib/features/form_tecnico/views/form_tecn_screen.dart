import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_tecn_provider.dart';
import 'add_form_tecn_screen.dart';
import 'edit_form_tecn_screen.dart';

class FormTecnScreen extends StatelessWidget {
  const FormTecnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formTecnProvider = Provider.of<FormTecnProvider>(context);
    
    // Llama a fetchFormTecn cuando la pantalla se carga por primera vez.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formTecnProvider.fetchFormTecn();
    });

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
        builder: (context, formTecnProvider, _) {
          if (formTecnProvider.formTecn.isEmpty) {
            return const Center(child: Text('No hay formularios registrados'));
          }
          return ListView.builder(
            itemCount: formTecnProvider.formTecn.length,
            itemBuilder: (context, index) {
              final formTecn = formTecnProvider.formTecn[index];
              return ListTile(
                title: Text(formTecn.nameForm),
                subtitle: Text('Nro. Formulario: ${formTecn.numForm}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navegar a la pantalla para editar el formulario técnico
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditFormTecnScreen(formTecn: formTecn),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        formTecnProvider.deleteFormTecn(formTecn.id);
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
