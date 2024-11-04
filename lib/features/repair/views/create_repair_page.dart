import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/repair.provider.dart';
import '../models/repair_request.model.dart';

class CreateRepairPage extends StatelessWidget {
  final TextEditingController _descriptionController = TextEditingController();
  final String productId;
  final String empresaId;
  final String sucursalId;

  CreateRepairPage({
    super.key,
    required this.productId,
    required this.empresaId,
    required this.sucursalId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitud de Reparación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Descripción del problema'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final repairProvider =
                    Provider.of<RepairProvider>(context, listen: false);

                final request = RepairRequestModel(
                  id: const Uuid().v4(),
                  userId:
                      'usuario_actual_id', // Cambiar según el contexto de autenticación
                  productId: productId,
                  empresaId: empresaId,
                  sucursalId: sucursalId,
                  description: _descriptionController.text,
                  status: 'pending',
                  requestDate: DateTime.now(),
                );

                repairProvider.createRepairRequest(request);

                Navigator.pop(context);
              },
              child: const Text('Enviar Solicitud'),
            ),
          ],
        ),
      ),
    );
  }
}
