import 'package:flutter/material.dart';

class homeActBar extends StatelessWidget {
  final String tit;
  final bool bckar;
  final bool titH;

  homeActBar({this.tit, this.bckar, this.titH});

  @override
  Widget build(BuildContext context) {
    bool _bckar = bckar ?? false;
    bool _titH = titH ?? true;

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0)],
                begin: Alignment(0, 0),
                end: Alignment(0, 1))),
        padding:
            EdgeInsets.only(top: 80.0, left: 24.0, right: 24.0, bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_bckar)
              Container(
                child: Image(
                  image: AssetImage(
                    "assets/icons/ex.png",
                  ),
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            if (_titH)
              Text(
                tit ?? "Action Bar",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
              ),
            Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(8.0)),
              alignment: Alignment.center,
              child: Text("0",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            )
          ],
        ));
  }
}
