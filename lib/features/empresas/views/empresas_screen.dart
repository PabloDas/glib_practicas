// empresas_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/empresa.model.dart';
import '../providers/empresa.provider.dart';
import 'edit_empresa_page.dart';

class EmpresasScreen extends StatefulWidget {
  const EmpresasScreen({super.key});

  @override
  _EmpresasScreenState createState() => _EmpresasScreenState();
}

class _EmpresasScreenState extends State<EmpresasScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EmpresaProvider>(context, listen: false).fetchEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    final empresaProvider = Provider.of<EmpresaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('addEmpresa');
            },
          ),
        ],
      ),
      body: Consumer<EmpresaProvider>(
        builder: (context, empresaProvider, child) {
          if (empresaProvider.empresas.isEmpty) {
            return const Center(child: Text('No hay empresas registradas'));
          }

          return ListView.builder(
            itemCount: empresaProvider.empresas.length,
            itemBuilder: (context, index) {
              final empresa = empresaProvider.empresas[index];
              return ListTile(
                title: Text(empresa.nombre),
                subtitle: Text('Dirección: ${empresa.direccion}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmpresaPage(empresa: empresa),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        empresaProvider.deleteEmpresa(empresa.id);
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
