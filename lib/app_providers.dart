import 'package:glib_practicas/features/auth/providers/auth.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (context) => AuthState()),
];
