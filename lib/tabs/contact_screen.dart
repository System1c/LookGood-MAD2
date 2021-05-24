import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';

class ContactS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Home Tab"),
          ),
          homeActBar(
            tit: "Contact Us",
            titH: true,
            bckar: false,
          ),
        ],
      ),
    );
  }
}
