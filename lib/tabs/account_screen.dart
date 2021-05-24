import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';

class AccS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Acc Tab"),
          ),
          homeActBar(
            tit: "Your Account",
            titH: true,
            bckar: false,
          ),
        ],
      ),
    );
  }
}
