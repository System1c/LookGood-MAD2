import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/cat_sort.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';
import 'package:lookgood_cb007942/services/authservice.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 450),
                  builder: (context, value, child) {
                    return ShaderMask(
                        shaderCallback: (rect) {
                          return RadialGradient(
                                  radius: value * 5,
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                    Colors.transparent,
                                    Colors.transparent
                                  ],
                                  stops: [0.0, 0.55, 0.6, 1.0],
                                  center: FractionalOffset(0.95, 0.05))
                              .createShader(rect);
                        },
                        child: cart());
                  }),
            );
          },
        ));
  }
}

int total = 0;

class _cartState extends State<cart> {
  AuthService _fireS = AuthService();

  Future _del() {
    _fireS.users.doc(_fireS.getUid()).collection("Cart").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                total = total + _pmap['price'];
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
                              if (total > 0) {
                                print(total);
                                total = 0;
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
          Padding(
              padding: EdgeInsets.only(top: 600.0, bottom: 15.0),
              child: Container(
                  height: 50.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Total: \$' + total.toString()),
                      SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          onPressed: () async {
                            await _del();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => cart()));
                          },
                          child: Center(
                            child: Text(
                              'Clear Cart',
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
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
