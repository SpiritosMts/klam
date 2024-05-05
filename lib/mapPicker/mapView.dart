import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../bindings.dart';
import '../myVoids.dart';
import '../styles.dart';
import 'mapCtr.dart';

class PickMapView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return    GetBuilder<MapPickerCtr>(
        builder: (ctr) => Row(children: [

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:  Text(
              'choose location'.tr,
              style:const TextStyle(
                fontSize: 25,
                color: normalTextCol,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /// marker button
          Center(
            child: Ink(
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: IconButton(

                style: ButtonStyle(

                ),
                // focusColor: blueColHex2,
                // highlightColor: blueColHex2,
                // hoverColor: blueColHex2,
                // splashColor: blueColHex2,
                // disabledColor: blueColHex2,
                icon: const Icon(Icons.place_rounded,size: 35),
                color: blueCol,
                onPressed: () {
                  fieldUnfocusAll();
                  mapsCtr.pushMarkerScreen();
                },
              ),
            ),
          ),
          //Text('Lat: ${getCtrl.lati}\nLng: ${getCtrl.lngi}\n'),


        ]),
    );
  }
}
