import 'package:flutter/material.dart';
import 'package:glib_practicas/features/ciudades/providers/ciudad.provider.dart';
import 'package:glib_practicas/features/empresas/providers/empresa.provider.dart';
import 'package:glib_practicas/features/empresas_sucursales/providers/sucursal.provider.dart';
import 'package:glib_practicas/features/form_tecnico/providers/form_tecn_provider.dart';
import 'package:glib_practicas/features/rubros/providers/rubro.provider.dart';
import 'package:provider/provider.dart';
import 'package:glib_practicas/app.dart';
import 'package:glib_practicas/inits.dart';
import 'package:glib_practicas/features/search/providers/search.provider.dart';
import 'package:glib_practicas/features/repair/providers/repair.provider.dart';
import 'package:glib_practicas/features/products/providers/product.provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initFirebase();

  initSharedPreferences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => RepairProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => EmpresaProvider()),
        ChangeNotifierProvider(create: (_) => SucursalProvider()),
        ChangeNotifierProvider(create: (_) => RubroProvider()),
        ChangeNotifierProvider(create: (_) => CiudadProvider()),
        ChangeNotifierProvider(create: (_) => FormTecnProvider())
      ],
      child: const App(),
    ),
  );
}
