
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:uuid/uuid.dart';

import '../../bindings.dart';

class RequestCtr extends GetxController {

  GlobalKey<FormState> formKeyCommon = GlobalKey<FormState>(); //

  TextEditingController nameTextController = TextEditingController();//name
  TextEditingController phoneTextController = TextEditingController();//phone
  TextEditingController descTextController = TextEditingController();//
  TextEditingController addressTextController = TextEditingController();//


  GoogleMapController? mapContr;
  Set<Marker> markers = {};




  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 0), () async {
      update();
    });

  }



}