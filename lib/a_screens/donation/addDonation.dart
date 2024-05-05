import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:klam/generalLayout/generalLayoutCtr.dart';

import '../../bindings.dart';
import '../../imagePicker/imageView.dart';
import '../../mapPicker/mapView.dart';
import '../../myUi.dart';
import '../../myVoids.dart';
import '../../styles.dart';

class DonationAdd extends StatefulWidget {
  const DonationAdd({super.key});

  @override
  State<DonationAdd> createState() => _DonationAddState();
}

class _DonationAddState extends State<DonationAdd> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgCol,
      child: GetBuilder<LayoutCtr>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                //fields
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,

                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child:  Text(
                          textAlign: TextAlign.start,
                          'general info'.tr,
                          style:const TextStyle(
                            fontSize: 25,
                            color: normalTextCol,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Form(
                        key: reqCtr.formKeyCommon,
                        child: Column(
                          children: [
                            // name_input (required)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(40),// max length
                                ],
                                //keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter your name'.tr;
                                  }
                                  return null;
                                },


                                controller: reqCtr.nameTextController,
                                style:const TextStyle(
                                    fontSize: 18,
                                    color: normalTextCol
                                ),

                                decoration:  InputDecoration(

                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

                                  labelText: 'name'.tr,
                                  labelStyle: TextStyle(
                                      color: fillCol
                                  ),
                                ),
                              ),
                            ),

                            //phone
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  //LengthLimitingTextInputFormatter(10),// max length
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                keyboardType: TextInputType.number,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter your phone number'.tr;
                                  }
                                  return null;
                                },
                                controller: reqCtr.phoneTextController,
                                style:const TextStyle(
                                    fontSize: 18,
                                    color: normalTextCol
                                ),
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  border: UnderlineInputBorder(),
                                  labelText: 'phone number'.tr,
                                  labelStyle: TextStyle(
                                      color: fillCol
                                  ),

                                ),
                              ),
                            ),
                            // address_input (required)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter local address'.tr;
                                  }
                                  return null;
                                },
                                controller: reqCtr.addressTextController,
                                style:const TextStyle(
                                  fontSize: 18,
                                  color: normalTextCol,
                                ),
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  border: UnderlineInputBorder(),
                                  labelText: 'local address'.tr,
                                  labelStyle: TextStyle(
                                      color: fillCol
                                  ),
                                ),
                              ),
                            ),
                            // desc_input
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(200),
                                ],
                                keyboardType: TextInputType.text,

                                controller: reqCtr.descTextController,
                                style:const TextStyle(
                                  fontSize: 18,
                                  color: normalTextCol,

                                ),
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  border: UnderlineInputBorder(),
                                  labelText: 'description'.tr,
                                  labelStyle: TextStyle(
                                      color: fillCol
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )
                    ),
                  ],
                ),
                ylwDivider(),
                PickMapView(),///map pick

                ylwDivider(),
                PickImagesView(),///images pick
                ylwDivider(),
                ///add
                SizedBox(height: 50),
                Container(
                  // key: ttrCtr.addItemKey,
                  height: 40.0,
                  width: 130.0,
                  child: FittedBox(
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        fieldUnfocusAll();
                        await showSuccess(
                        sucText: 'your donation has been submitted',
                        btnOkPress: () {
                          //Get.back();
                        },
                        );
                        //reqCtr.addReq();
                      },
                      backgroundColor: blueCol,
                      label: Row(
                        children: [
                          Text(
                            'Add'.tr,
                            style: TextStyle(color: Colors.white,fontSize: 22),
                          ),
                          SizedBox(width: 5),

                          Icon(Icons.location_on,color: Colors.white,),

                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
