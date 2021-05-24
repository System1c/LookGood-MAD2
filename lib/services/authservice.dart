import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/home.dart';
import 'package:lookgood_cb007942/login_page.dart';
import 'package:lookgood_cb007942/services/errorHand.dart';

class AuthService {
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
}
