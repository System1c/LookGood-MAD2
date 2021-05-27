import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/home.dart';
import 'package:lookgood_cb007942/services/authservice.dart';

class chckout extends StatefulWidget {
  @override
  _chckoutState createState() => _chckoutState();
}

class _chckoutState extends State<chckout> {
  AuthService _fireS = AuthService();

  final CollectionReference _user =
      FirebaseFirestore.instance.collection("Users");

  User _us = FirebaseAuth.instance.currentUser;

  Future _del() {
    _user.doc(_us.uid).collection("Cart").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/like.png",
              width: 150.0,
              height: 150.0,
            ),
            Text(
              "You have completed your Purchase!",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (AuthService()
                    .users
                    .doc(AuthService().getUid())
                    .collection("Address")
                    .doc("Address0")
                    .get() ==
                null)
              Text(
                "Please enter your Address to prevent delays in your order",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            GestureDetector(
              onTap: () async {
                await _del();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                height: 65.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(30.0)),
                alignment: Alignment.center,
                child: Text(
                  "Go back home",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
