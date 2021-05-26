import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/home.dart';
import 'package:lookgood_cb007942/login_page.dart';
import 'package:lookgood_cb007942/services/errorHand.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  handleauth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else
            return LoginPage();
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
      print('Signed in');
    }).catchError((e) {
      ErrorHand().errorDialog(context, e);
    });
  }

  signUp(String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  resetPassW(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  String getCurrentEm() {
    return _firebaseAuth.currentUser.email;
  }

  String getCurrentDet() {
    return _firebaseAuth.currentUser.displayName;
  }

  setCurrentDet(name) {
    return FirebaseAuth.instance.currentUser.updateProfile(displayName: name);
  }

  String getUid() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference<Map<String, dynamic>> prodRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection("Users");
}
