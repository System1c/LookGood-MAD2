import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';

class SearchS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Search Tab"),
          ),
          homeActBar(
            tit: "Search",
            titH: true,
            bckar: false,
          ),
        ],
      ),
    );
  }
}
