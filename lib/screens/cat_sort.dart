import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/products_details.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';

class catsort extends StatefulWidget {
  final String catIda;

  const catsort({this.catIda});

  @override
  _catsortState createState() => _catsortState();
}

class _catsortState extends State<catsort> {
  final CollectionReference _prodRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    print(widget.catIda);
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: _prodRef
                .orderBy("pid")
                .startAt([widget.catIda]).endAt([widget.catIda]).get(),
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
                                builder: (context) => prodpage(
                                      productID: document.id,
                                    )));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1.0,
                                  blurRadius: 30.0,
                                )
                              ]),
                          height: 350.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 24.0,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 350,
                                width: 650,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    "${document.data()['images'][0]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          document.data()['name'] ??
                                              "Product Name",
                                          style: TextStyle(
                                              backgroundColor: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                          "\$${document.data()['price']}" ??
                                              "Price",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Theme.of(context)
                                                  .accentColor)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
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
            tit: "Home",
            titH: false,
            bckar: true,
          ),
        ],
      ),
    );
  }
}

mixin $ {}
