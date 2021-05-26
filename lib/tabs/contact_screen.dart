import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 120.0),
            height: 500.0,
            child: MapSample(),
          ),
          Container(
              padding: EdgeInsets.only(top: 550.0, left: 23.0),
              child: Text(
                "Get in touch!",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
              )),
          Container(
              padding: EdgeInsets.only(top: 595.0, left: 23.0),
              child: Text(
                "LookGood Pvt Ltd",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              )),
          Container(
              padding: EdgeInsets.only(top: 610.0, left: 24.0),
              child: Text(
                "Union Place,",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              )),
          Container(
              padding: EdgeInsets.only(top: 625.0, left: 24.0),
              child: Text(
                "Colombo 10.",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              )),
          Container(
            padding: EdgeInsets.only(top: 670.0, left: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    CustomLaunch('tel: +94112729729');
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Icon(Icons.phone),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CustomLaunch('mailto:support@lookgood.com');
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Icon(Icons.email),
                  ),
                )
              ],
            ),
          ),
          homeActBar(
            tit: "Contact Us",
            titH: true,
            bckar: false,
            crt: false,
          ),
        ],
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.918661800288345, 79.8612293602041),
    zoom: 70,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.918661800288345, 79.8612293602041),
      tilt: 59.440717697143555,
      zoom: 70);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To LookGood Store!'),
        icon: Icon(Icons.navigate_next),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

void CustomLaunch(cmd) async {
  if (await canLaunch(cmd)) {
    await launch(cmd);
  } else {
    print("error in funct");
  }
}
