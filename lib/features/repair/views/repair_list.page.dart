import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/repair.provider.dart';

class RepairListPage extends StatelessWidget {
  const RepairListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repairProvider = Provider.of<RepairProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Solicitudes de Reparación'),
      ),
      body: FutureBuilder(
        future: repairProvider.getUserRepairRequests('usuario_actual_id'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (repairProvider.requests.isEmpty) {
            return const Center(child: Text('No tienes solicitudes de reparación.'));
          }

          return ListView.builder(
            itemCount: repairProvider.requests.length,
            itemBuilder: (context, index) {
              final request = repairProvider.requests[index];

              return ListTile(
                title: Text(request.description),
                subtitle: Text('Estado: ${request.status}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    repairProvider.deleteRepairRequest(request.id);
                  },
                ),
                onTap: () {
                  // Lógica para editar la solicitud, si es necesario
                },
              );
            },
          );
        },
      ),
    );
  }
}
