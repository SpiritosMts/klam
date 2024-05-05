import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import '../../main.dart';
import '../myVoids.dart';

double animateZoom = 16.0;
LatLng susahLoc = LatLng(35.821430, 10.634422);
CameraPosition get userCurrentPos => CameraPosition(target: susahLoc, zoom: 10.0);

Future<void> moveCamPosTo(Completer<GoogleMapController> gMapctr,double zoom,double lat, double lng) async {
  final CameraPosition newCameraPosition = CameraPosition(
    target: LatLng(lat, lng),
    zoom: zoom,
  );
  final  ctr = await gMapctr.future;
  await ctr.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition)).whenComplete(() {
    //print('## finish camera animation');
  });
}



double calculateDistanceOnMap(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = math.cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * math.asin(math.sqrt(a));
}

Future<LatLng> getCurrentLocation(gMapCtr,{bool moveCamToUser = false, printErr= true}) async {
  //default position

  //LatLng currUserPos = LatLng(sUserLat, sUserLng);
  LatLng currUserPos = LatLng(0, 0);
  /// without initial LatLng
 await Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best).then((pos)  {
    // affect curr user pos
     currUserPos =LatLng(pos.latitude, pos.longitude);
     //print('### curr_pos >${currUserPos.latitude}/${currUserPos.longitude} <');
     sharedPrefs!.setDouble('savedUserLat', currUserPos.latitude);
     sharedPrefs!.setDouble('savedUserLng', currUserPos.longitude);
     //animate cam
   if(moveCamToUser) moveCamPosTo(gMapCtr,animateZoom,currUserPos.latitude, currUserPos.longitude);
  }).catchError((err) {
    print("## Failed to get user current location : $err");
   if(printErr) showTos('can\'t found you location'.tr);
  });
  return currUserPos;
}

Future<void> openGoogleMapApp(double latitude, double longitude) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}
