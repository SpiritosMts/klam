import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocod;

import '../bindings.dart';
import '../myVoids.dart';
import 'mapVoids.dart';
import 'markerView.dart';

class MapPickerCtr extends GetxController {
  final Completer<GoogleMapController> gMapctr = Completer();
  final TextEditingController addressCtr = reqCtr.addressTextController;///address to get cords from

  double lati = 0.0;
  double lngi = 0.0;
  double c_lati = 0.0; // user lat
  double c_lngi = 0.0; // use lng
  bool shouldGetFromAddress = false;///change later


  final Map<String, Marker> markers = {};


  @override
  void onInit() {
    //print('## onInit MapPickerCtr');
  }



  void getSavedLocation() {
    if (lati != 0.0 && lngi != 0.0) {
      print('## go to saved position');
      c_lati = lati;
      c_lngi = lngi;
      Future.delayed(Duration.zero, () {
        setMarker(c_lati, c_lngi);
        moveCamPosTo(gMapctr,animateZoom,c_lati,c_lngi);

      });
    }else{
      Future.delayed(Duration.zero, () {
        setMarker(userCurrentPos.target.latitude, userCurrentPos.target.longitude);
        moveCamPosTo(gMapctr,10.0,userCurrentPos.target.latitude,userCurrentPos.target.longitude);

      });
    }


  }

  /// Converting.. { Coords <= Adress }
  getLatLngFromAdress(String pAddress) async {
    try {
      List<geocod.Location> newPos = await geocod.locationFromAddress(pAddress);
      geocod.Location adressMark = newPos[0];
      lati = adressMark.latitude;
      lngi = adressMark.longitude;

      Get.to(() => GoogleMapMarker());
    } on Exception catch (e) {
      showTos('cant find given address'.tr);
    }
    update();
  }
  void setMarker(double lat, double lng) async {
    markers.clear();

    final marker = Marker(
      draggable: true,
      onDragEnd: (pos) => setMarker(pos.latitude, pos.longitude),
      markerId: const MarkerId('markerID'),
      position: LatLng(lat, lng),
    );

    c_lati = lat;
    c_lngi = lng;
    markers['chosenPos'] = marker;
    update();

    print('## marker at => $c_lati / $c_lngi');
  }

  void save() async {

    if (c_lati != 0 && c_lngi != 0) {
      print('## new marker saved < $c_lati / $c_lngi >');
      lati = c_lati;
      lngi = c_lngi;
      shouldGetFromAddress = false;

    }
    Get.back();
    update();
  }


  pushMarkerScreen() {
    String inputedAddress = '${addressCtr.text}';
    if (shouldGetFromAddress) {
      if (inputedAddress.isNotEmpty) {
        getLatLngFromAdress(inputedAddress);
      }else {
        showTos('you need to write an address'.tr);
      }
    } else {
      Get.to(() => GoogleMapMarker());
    }
  }


}
