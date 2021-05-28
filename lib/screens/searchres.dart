import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/products_details.dart';

class searchres extends StatelessWidget {
  final String prid;
  final Function onP;
  final String img;
  final String tit;
  final String prc;

  const searchres({this.onP, this.img, this.tit, this.prc, this.prid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => prodpage(
                      productID: prid,
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
                    "$img",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tit ?? "Product Name",
                          style: TextStyle(
                              backgroundColor: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      Text(prc ?? "Price",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).accentColor)),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
