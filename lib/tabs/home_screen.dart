import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';

class HomeS extends StatelessWidget {
  final CollectionReference _prodRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _prodRef.get(),
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
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0)),
                        height: 350.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            "${document.data()['images'][0]}",
                            fit: BoxFit.cover,
                          ),
                        ));
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
            titH: true,
            bckar: false,
          ),
        ],
      ),
    );
  }
}
