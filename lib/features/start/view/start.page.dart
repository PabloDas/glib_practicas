import 'package:flutter/material.dart';
import 'package:glib_practicas/app_router.dart';
import 'package:glib_practicas/utils/app_preferences.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final prefs = AppPreferences();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (prefs.usuario_id.isEmpty) {
        Navigator.pushReplacementNamed(context, RouteNames.login.name);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.home.name);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
