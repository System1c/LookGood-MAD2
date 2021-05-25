import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/checkout.dart';
import 'package:share/share.dart';

import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';
import 'package:lookgood_cb007942/screens/widgets/prodsize.dart';

class prodpage extends StatefulWidget {
  final String productID;

  const prodpage({this.productID});
  @override
  _prodpageState createState() => _prodpageState();
}

class _prodpageState extends State<prodpage> {
  final CollectionReference _prodRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference _user =
      FirebaseFirestore.instance.collection("Users");

  User _us = FirebaseAuth.instance.currentUser;

  String _sizesel = "0";

  Future _atc() {
    return _user
        .doc(_us.uid)
        .collection("Cart")
        .doc(widget.productID)
        .set({"size": _sizesel});
  }

  final SnackBar _sb = SnackBar(content: Text("Product Added to Cart!"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _prodRef.doc(widget.productID).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error:  ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentd = snapshot.data.data();
              List imglist = documentd['images'];
              List prdsize = documentd['size'];
              return ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Container(
                    height: 400.0,
                    child: PageView(
                      children: [
                        for (var j = 0; j < imglist.length; j++)
                          Container(
                            child: Image.network(
                              "${imglist[j]}",
                              fit: BoxFit.cover,
                            ),
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chckout()));
                          },
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage("assets/icons/buy.png"),
                              height: 22.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _atc();
                              ScaffoldMessenger.of(context).showSnackBar(_sb);
                            },
                            child: Container(
                                height: 65.0,
                                margin: EdgeInsets.only(left: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 24.0),
                      child: Row(
                        children: [
                          Text("Select Size: ",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              )),
                          prodsize(
                            prds: prdsize,
                            onSel: (sze) {
                              _sizesel = sze;
                            },
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, bottom: 4.0, left: 24.0, right: 24.0),
                    child: Text(
                      "${documentd['name']}" ?? "Product Name",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24.0),
                      child: Row(
                        children: [
                          Text("\$${documentd['price']} " ?? "Price",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor)),
                          GestureDetector(
                            onTap: () {
                              Share.share(
                                  'Check this out on LookGood! https://www.lookgood.com/product/${widget.productID}');
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/icons/share.png"),
                                height: 22.0,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text("${documentd['desc']}" ?? "Description",
                        style: TextStyle(fontSize: 16.0)),
                  ),
                ],
              );
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        homeActBar(
          tit: "Home",
          titH: false,
          bckar: true,
          backhave: false,
        ),
      ],
    ));
  }
}
