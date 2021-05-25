import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/cart.dart';
import 'package:lookgood_cb007942/screens/checkout.dart';

class homeActBar extends StatelessWidget {
  final String tit;
  final bool bckar;
  final bool titH;
  final bool backhave;
  final bool crt;
  final bool btn;

  homeActBar(
      {this.tit, this.bckar, this.titH, this.backhave, this.btn, this.crt});

  @override
  Widget build(BuildContext context) {
    bool _bckar = bckar ?? false;
    bool _titH = titH ?? true;
    bool _backhave = backhave ?? true;
    bool _btn = btn ?? false;
    bool _crt = crt ?? true;

    final CollectionReference _user =
        FirebaseFirestore.instance.collection("Users");

    User _us = FirebaseAuth.instance.currentUser;

    return Container(
        decoration: BoxDecoration(
            gradient: _backhave
                ? LinearGradient(
                    colors: [Colors.white, Colors.white.withOpacity(0)],
                    begin: Alignment(0, 0),
                    end: Alignment(0, 1))
                : null),
        padding:
            EdgeInsets.only(top: 80.0, left: 24.0, right: 24.0, bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_bckar)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Image(
                    image: AssetImage(
                      "assets/icons/ex.png",
                    ),
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
            if (_titH)
              Text(
                tit ?? "Action Bar",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
              ),
            if (_crt)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => cart()));
                },
                child: Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    alignment: Alignment.center,
                    child: StreamBuilder(
                      stream: _user.doc(_us.uid).collection("Cart").snapshots(),
                      builder: (context, snapshot) {
                        int _ttitm = 0;
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List _docu = snapshot.data.docs;
                          _ttitm = _docu.length;
                        }
                        return Text("$_ttitm" ?? "0",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black));
                      },
                    )),
              ),
            if (_btn)
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => chckout()));
                },
                child: Container(
                  width: 42.0,
                  height: 42.0,
                  child: Image(
                    image: AssetImage(
                      "assets/icons/check.png",
                    ),
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
          ],
        ));
  }
}
