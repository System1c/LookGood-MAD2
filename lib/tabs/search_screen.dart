import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/searchres.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';
import 'package:lookgood_cb007942/services/authservice.dart';

class SearchS extends StatefulWidget {
  @override
  _SearchSState createState() => _SearchSState();
}

class _SearchSState extends State<SearchS> {
  AuthService _fireS = AuthService();

  String _srch = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_srch.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: _fireS.prodRef
                  .orderBy("name")
                  .startAt([_srch]).endAt(["$_srch\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 128.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return searchres(
                        tit: document.data()['name'],
                        img: document.data()['images'][0],
                        prc: "\$${document.data()['price']}",
                        prid: document.id,
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
          Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 24.0,
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12.0)),
              child: TextField(
                onSubmitted: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      _srch = val;
                    });
                  }
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for your Products",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
