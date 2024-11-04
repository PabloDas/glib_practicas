import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glib_practicas/features/auth/models/firebase_user.model.dart';

class AuthState extends ChangeNotifier {
  FirebaseFirestore client = FirebaseFirestore.instance;

  // Usuario actual autenticado en la app

  UserModel? currentUser;

  AuthState() {
    _init();
  }
  // Inicializa el estado de autenticación
  _init() {
    // Escucha los cambios en el estado de autenticación
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // Si el usuario tiene un displayName en FirebaseAuth, lo usamos directamente
        if (user.displayName != null && user.displayName!.isNotEmpty) {
          currentUser = UserModel(
            uid: user.uid,
            displayName:
                user.displayName!, // Usamos el displayName de FirebaseAuth
            email: user.email!,
            phone: user.phoneNumber ?? '',
            type: 'user', // Esto puede cambiar según tu lógica de tipo
          );
          notifyListeners(); // Notificamos que el usuario cambió
        } else {
          // Si no tiene displayName en FirebaseAuth, lo buscamos en Firestore
          getCurrentUserData(user.uid).then((value) {
            currentUser = value;
            notifyListeners(); // Notificamos que el usuario cambió
          });
        }
      } else {
        // Si no hay usuario autenticado, limpiamos el currentUser
        currentUser = null;
        notifyListeners();
      }
    });
  }

  Future<bool> checkIsLoggedIn() async {
    return FirebaseAuth.instance.currentUser == null;
  }

  Future<void> createUsers(UserModel usuario) async {
    await FirebaseFirestore.instance.collection('users').doc(usuario.uid).set(
      {
        'displayName': usuario.displayName,
        'email': usuario.email,
        'phone': usuario.phone,
        'type': usuario.type,
      },
    );
    // Actualizamos el perfil FirebaseAuth con el displayName
    await FirebaseAuth.instance.currentUser
        ?.updateDisplayName(usuario.displayName);
  }

  Future<UserModel?> getCurrentUserData(String idUsuario) async {
    var collection = client.collection('users');
    var snapshot = await collection.doc(idUsuario).get();

    var u = snapshot.data();

    return u != null ? userModelFromMap(u) : null;
  }

  logout(Function redirect) {
    var firebase = FirebaseAuth.instance;
    firebase.signOut().then((value) {
      redirect();
    });
  }

  Future<List<UserModel>?> getUsuarios(String filtro) async {
    List<UserModel>? usuarios = [];

    var collection = (filtro.isEmpty)
        ? client.collection('users').orderBy('displayName')
        : client
            .collection('users')
            .where('type', isEqualTo: filtro)
            .orderBy('displayName');

    try {
      var snapshot = await collection.get();
      List<DocumentSnapshot> docs = snapshot.docs;

      for (var doc in docs) {
        usuarios.add(UserModel(
          uid: doc.id,
          displayName: doc['displayName'],
          email: doc['email'],
          phone: doc['phone'],
          type: doc['type'],
        ));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      usuarios = [];
    }

    return usuarios;
  }

  Future<UserModel?> getUserData(String id) async {
    var collection = client.collection('users');
    var snapshot = await collection.doc(id).get();

    var u = snapshot.data();

    return u != null ? userModelFromMap(u) : null;
  }

  Future<void> userEnPostulacion(
      String idUser, String nombre, String celular) async {
    await client.collection('users').doc(idUser).update(
      {'type': 'operario', 'estado': 'postulacion'},
    );

    await client.collection('users/$idUser/postulacion').doc('postulacion').set(
      {
        'contacto_nombre': nombre,
        'celular': celular,
      },
    );
  }

  Future<void> setUserEstado(String id, String estado) async {
    await client.collection('users').doc(id).update(
      {
        'estado': estado,
      },
    );
  }
}
