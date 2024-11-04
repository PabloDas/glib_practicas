import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glib_practicas/features/auth/providers/auth.provider.dart';
import 'package:glib_practicas/features/empresas_sucursales/views/sucursales_screen.dart';
import 'package:glib_practicas/utils/app_preferences.dart';
import 'package:provider/provider.dart';

import 'package:glib_practicas/app_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  AppPreferences prefs = AppPreferences();

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final auth = FirebaseAuth.instance;
              auth.signOut().then((value) {
                AppPreferences prefs = AppPreferences();
                prefs.cleanLocalStorage();
                Navigator.of(context).pushReplacementNamed('/');
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome ${authState.currentUser?.displayName}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            // Botón para navegar a la página de ABM de productos
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.products.name);
              },
              child: const Text('ABM Productos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'empresas');
              },
              child: const Text('Gestionar Empresas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.sucursal.name);
              },
              child: const Text('Ver Sucursales'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.rubros.name);
              },
              child: const Text('ABM Rubros'),
            ),
            const SizedBox(height: 20),
                        ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.ciudad.name);
              },
              child: const Text('ABM Ciudades'),
            ),
            const SizedBox(height: 20),
            // Boton para navegar a la página de búsqueda
            ElevatedButton(
              onPressed: () {
                // Navega a la página de búsqueda
                Navigator.pushNamed(context, RouteNames.search.name);
              },
              child: const Text('Buscar productos'),
            ),
            const SizedBox(height: 20),
            // Botón para navegar a la página de solicitud de reparación
            ElevatedButton(
              onPressed: () {
                // Navega a la página de creación de solicitud de reparación
                Navigator.pushNamed(
                  context,
                  RouteNames.createRepair.name,
                  arguments: {
                    'productId': 'productId_example',
                    'empresaId': 'empresaId_example',
                    'sucursalId': 'sucursalId_example',
                  },
                );
              },
              child: const Text('Solicitar reparación'),
            ),
          ],
        ),
      ),
    );
  }
}
