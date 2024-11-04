import 'package:flutter/material.dart';
import 'package:glib_practicas/features/auth/views/auth.page.dart';
import 'package:glib_practicas/features/ciudades/views/ciudades_screen.dart';
import 'package:glib_practicas/features/empresas/models/empresa.model.dart';
import 'package:glib_practicas/features/empresas/views/add_empresa_page.dart';
import 'package:glib_practicas/features/empresas/views/edit_empresa_page.dart';
import 'package:glib_practicas/features/empresas/views/empresas_screen.dart';
import 'package:glib_practicas/features/empresas_sucursales/models/sucursal.model.dart';
import 'package:glib_practicas/features/empresas_sucursales/views/edit_sucursal_screen.dart';
import 'package:glib_practicas/features/empresas_sucursales/views/sucursales_screen.dart';
import 'package:glib_practicas/features/home/views/home.page.dart';
import 'package:glib_practicas/features/products/views/products_screen.dart';
import 'package:glib_practicas/features/repair/views/create_repair_page.dart';
import 'package:glib_practicas/features/repair/views/repair_list.page.dart';
import 'package:glib_practicas/features/rubros/views/rubros_screen.dart';
import 'package:glib_practicas/features/search/views/search.page.dart';
import 'package:glib_practicas/features/start/view/start.page.dart';

enum RouteNames {
  home,
  login,
  search,
  createRepair,
  repairList,
  addEmpresa,
  products,
  editEmpresa,
  editSucursal,
  sucursal,
  rubros,
  ciudad
}

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (context) => const StartPage(),
  RouteNames.login.name: (context) => const AuthPage(),
  RouteNames.home.name: (context) => HomePage(),
  RouteNames.search.name: (context) => SearchPage(),
  RouteNames.products.name: (context) => ProductsScreen(),
  RouteNames.sucursal.name: (context) => SucursalesScreen(),
  RouteNames.rubros.name: (context) => RubrosScreen(),
  RouteNames.ciudad.name: (context) => CiudadesScreen(),

  // Nueva ruta para la pantalla de empresas
  RouteNames.addEmpresa.name: (context) => AddEmpresaPage(),
  // Nueva ruta para la lista de empresas
  'empresas': (context) => const EmpresasScreen(),
  // Nueva rutas para la funcionalidad de reparación
  RouteNames.createRepair.name: (context) => CreateRepairPage(productId: '12345', empresaId: '67890', sucursalId: '54321'),
  RouteNames.repairList.name: (context) => const RepairListPage(),
  RouteNames.addEmpresa.name: (context) => AddEmpresaPage(),
  RouteNames.editEmpresa.name: (context) => EditEmpresaPage(empresa: ModalRoute.of(context)!.settings.arguments as Empresa),
  RouteNames.editSucursal.name: (context) => EditSucursalScreen(sucursal: ModalRoute.of(context)!.settings.arguments as Sucursal),

};
