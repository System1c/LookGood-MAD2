import 'package:flutter/material.dart';

class prodsize extends StatefulWidget {
  final List prds;
  final Function(String) onSel;

  const prodsize({this.prds, this.onSel});

  @override
  _prodsizeState createState() => _prodsizeState();
}

class _prodsizeState extends State<prodsize> {
  int _sel = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Row(
        children: [
          for (var x = 0; x < widget.prds.length; x++)
            GestureDetector(
              onTap: () {
                widget.onSel("${widget.prds[x]}");
                setState(() {
                  _sel = x;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: _sel == x
                        ? Theme.of(context).accentColor
                        : Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${widget.prds[x]}",
                  style: TextStyle(
                      color: _sel == x ? Colors.white : Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
        ],
      ),
    );
  }
}
