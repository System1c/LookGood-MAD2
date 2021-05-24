import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tabs/home_screen.dart';
import 'tabs/search_screen.dart';
import 'tabs/account_screen.dart';
import 'tabs/contact_screen.dart';


import 'screens/widgets/top.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabPCont;
  int _stab = 0;

  @override
  void initState() {
    _tabPCont = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabPCont.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: PageView(
          controller: _tabPCont,
          onPageChanged: (num) {
            setState(() {
              _stab = num;
            });
          },
          children: [
            HomeS(),
            SearchS(),
            AccS(),
            ContactS()
          ],
        )),
        top(
          seletab: _stab,
          tabC: (num) {
            setState(() {
              _tabPCont.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            });
          },
        ),
      ],
    ));
  }
}
