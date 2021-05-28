import 'package:flutter/material.dart';

class top extends StatefulWidget {
  final int seletab;
  final Function(int) tabC;

  top({this.seletab, this.tabC});

  @override
  _topState createState() => _topState();
}

// ignore: camel_case_types
class _topState extends State<top> {
  int _selTab = 2;

  Widget build(BuildContext context) {
    _selTab = widget.seletab ?? 0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          topbtn(
            imagepath: "assets/icons/home.png",
            sel: _selTab == 0 ? true : false,
            onPr: () {
              widget.tabC(0);
            },
          ),
          topbtn(
            imagepath: "assets/icons/srch.png",
            sel: _selTab == 1 ? true : false,
            onPr: () {
              widget.tabC(1);
            },
          ),
          topbtn(
            imagepath: "assets/icons/acc.png",
            sel: _selTab == 2 ? true : false,
            onPr: () {
              widget.tabC(2);
            },
          ),
          topbtn(
            imagepath: "assets/icons/more.png",
            sel: _selTab == 3 ? true : false,
            onPr: () {
              widget.tabC(3);
            },
          )
        ],
      ),
    );
  }
}

class topbtn extends StatelessWidget {
  final String imagepath;
  final bool sel;
  final Function onPr;
  topbtn({this.imagepath, this.sel, this.onPr});
  @override
  Widget build(BuildContext context) {
    bool _select = sel ?? false;

    return GestureDetector(
        onTap: onPr,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: _select
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                      width: 2.0))),
          child: Image(
            image: AssetImage(imagepath ?? "assets/icons/home.png"),
            width: 26.0,
            height: 26.0,
            color: _select ? Theme.of(context).accentColor : Colors.black,
          ),
        ));
  }
}
