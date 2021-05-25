import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/cat_sort.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';
import 'package:lookgood_cb007942/services/authservice.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  AuthService _fireS = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _fireS.users.doc(_fireS.getUid()).collection("Cart").get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:  ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 130.0,
                    bottom: 24.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => catsort(
                                  catIda: document.data()['pid'],
                                ),
                              ));
                        },
                        child: FutureBuilder(
                            future: _fireS.prodRef.doc(document.id).get(),
                            builder: (context, productSnap) {
                              if (productSnap.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${productSnap.error}"),
                                  ),
                                );
                              }

                              if (productSnap.connectionState ==
                                  ConnectionState.done) {
                                Map _pmap = productSnap.data.data();

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            "${_pmap['images'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_pmap['name']}",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Row(children: [
                                                Text(
                                                  "\$${_pmap['price']}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(width: 150),
                                                Text(
                                                  "Size - ${document.data()['size']}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }));
                  }).toList(),
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
            bckar: true,
            tit: "Cart",
            btn: true,
            crt: false,
          )
        ],
      ),
    );
  }
}
