import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glib_practicas/features/auth/models/firebase_user.model.dart';
import 'package:glib_practicas/features/auth/providers/auth.provider.dart';
import 'package:glib_practicas/features/auth/views/auth_form.dart';
import 'package:glib_practicas/utils/alerts.dart';
import 'package:glib_practicas/utils/app_preferences.dart';
import 'package:glib_practicas/utils/types.dart';

import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _resetFn(
    String emailpassword,
    BuildContext ctx,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailpassword);
      Navigator.of(context).pop();

      Alerts.snackBar(context, 'Password Reset Email Sent');
    } catch (e) {
      Alerts.snackBar(context, 'Invalid Input!');
    }
  }

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    String phoneArea,
    String phone,
    String type,
    String estado,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });

      // LOGIN CON FIREBASE
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        final prefs = AppPreferences();

        prefs.usuario_nombre = userCredential.user?.displayName ?? '';
      } else {
        AuthState authState = Provider.of<AuthState>(context, listen: false);

        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _auth.currentUser?.updateDisplayName(userName);
        await authState.createUsers(UserModel(
          displayName: userName,
          type: TipoUsuarioApp.CLIENTE.name,
          uid: userCredential.user?.uid,
          email: email,
          phone: phoneArea + phone,
        ));

        final prefs = AppPreferences();

        prefs.usuario_nombre = userName;
      }

      if (userCredential.user != null) {
        final prefs = AppPreferences();
        prefs.usuario_id = userCredential.user!.uid;
        prefs.usuario_email = email;

        prefs.usuario_tipo = TipoUsuarioApp.CLIENTE.name;

        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacementNamed(context, '/');
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: Text('User null'),
          backgroundColor: Colors.red,
          //backgroundColor: Theme.of(ctx).errorColor,
        ));
      }
    } on PlatformException catch (err) {
      var message =
          "Algo salio mal validando su usuario, por favor verifica tus credenciales.";

      if (err.message != null) {
        message = err.message!;
      }
      Alerts.snackBar(context, message);

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      // ignore: avoid_print
      print(err);
      String message =
          'Algo salio mal validando su usuario, por favor verifica tus credenciales.';

      if (err.toString().contains('email-already-in-use')) {
        message =
            'Ya existe un usuario con este correo, cambiar contraseña en caso de no recordarla.';
      } else if (err.toString().contains('wrong-password')) {
        message = 'Contraseña incorrecta, por favor intente de nuevo.';
      } else if (err.toString().contains('too-many-requests')) {
        message = 'Muchos intentos incorrectos. Puede recuperar su contraseña.';
      } else if (err.toString().contains('weak-password')) {
        message = 'Ingresar contraseña mayor a 6 caracteres';
      }

      Alerts.snackBar(context, message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthForm(_submitAuthForm, _isLoading, _resetFn),
    );
  }
}
