import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../bindings.dart';
import '../main.dart';
import '../myVoids.dart';
import '../styles.dart';
import 'pickImage.dart';
import 'imageCtr.dart';

class PickImagesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerCtr>(
        builder: (ctr) {
          return Column(
              children: [
                ///LOGO
                // Row(
                //  // key: ttrCtr.chooseImageKey,
                //   children: [
                //     //text
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 8.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Container(
                //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //             child: Text(
                //               'choose logo'.tr,
                //               style: const TextStyle(
                //                 fontSize: 25,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //           // SizedBox(
                //           //   width: 40,
                //           //   height: 40,
                //           //   child: FloatingActionButton.extended(
                //           //     heroTag: 'addLogo',
                //           //     onPressed: () {
                //           //       fieldUnfocusAll();
                //           //       if (getCtrl.logoDeleted) {
                //           //         getCtrl.showChoiceDialog(context, false);
                //           //       } else {
                //           //         getCtrl.proposeDeleteLogo(context);
                //           //       }
                //           //     },
                //           //     label: const Icon(Icons.image),
                //           //   ),
                //           // ),
                //         ],
                //       ),
                //     ),
                //
                //     /// logo_image
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //       child: SizedBox(
                //           width: 100,
                //           height: 100,
                //           child: imgsCtr.logoDeleted ? (imgsCtr.imageFile != null) ?
                //                   /// new local logo (grey delete)
                //                   Stack(
                //                       children: [
                //                         CircleAvatar(
                //                           radius: 100.0,
                //                           backgroundColor: Colors.white,
                //                           foregroundImage: FileImage(File(imgsCtr.imageFile!.path)),
                //                         ),
                //                         Positioned(
                //                           top: -10,
                //                           right: -10,
                //                           child: IconButton(
                //                             icon: Icon(Icons.close),
                //                             color: Colors.grey,
                //                             splashRadius: 1,
                //                             onPressed: () {
                //                               imgsCtr.clearImageFile();
                //                             },
                //                           ),
                //                         ),
                //                       ],
                //                     )
                //                   /// jobType image
                //                   : GestureDetector(
                //                       onTap: () async {
                //                         if(imgsCtr.adverted){
                //                           fieldUnfocusAll();
                //                           if (imgsCtr.logoDeleted) {
                //                             PickedFile img = await showImageChoiceDialog();
                //                              imgsCtr.updateImage(img);
                //                           } else {
                //                             imgsCtr.proposeDeleteLogo();
                //                           }
                //                         }
                //                       },
                //                       child: Stack(
                //                         alignment: Alignment.center,
                //
                //                         children: [
                //                           ClipRRect(
                //                             borderRadius: BorderRadius.circular(50.0),
                //                             child: Container(
                //                               color: blueColHex2,
                //                             ),
                //                           ),
                //                           ClipRRect(
                //                             borderRadius: BorderRadius.circular(8.0),
                //                             child: Image.asset(
                //                               getJobImagePathByJobName(radioCtr.showNewJob?'':jobNames[radioCtr.selectedJobIndex]),
                //                               color: yellowColHex,
                //                               height: 80.0,
                //                               width: 80.0,
                //                             ),
                //                           ),
                //                           if(!imgsCtr.adverted) Positioned(
                //                             top: 0,
                //                             left: 0,
                //                             child: GestureDetector(
                //                               onTap: (){
                //                                 double lat = mapsCtr.lati;
                //                                 double lng = mapsCtr.lngi;
                //                                  if(lat !=0.0 && lng !=0.0){
                //                                   goForAdvertisePay(LatLng(lat, lng),isItem: false);
                //                                 }else{
                //                                   showTos('you need to select the store location first'.tr);
                //                                 }
                //                               },
                //                               child: Image.asset(
                //                                   height: 35,
                //                                   width: 35,
                //                                   'assets/plus.png'
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       )
                //           )
                //               /// old network logo (red delete)
                //               : Stack(
                //                   children: [
                //                     CircleAvatar(
                //                       radius: 100.0,
                //                       backgroundColor: Colors.white,
                //                       foregroundImage: NetworkImage(imgsCtr.logoUrl),
                //                     ),
                //                     Positioned(
                //                       top: -10,
                //                       right: -10,
                //                       child: IconButton(
                //                         icon: const Icon(Ionicons.close_circle),
                //                         color: Colors.redAccent,
                //                         splashRadius: 1,
                //                         onPressed: () {
                //                           imgsCtr.proposeDeleteLogo();
                //                         },
                //                       ),
                //                     ),
                //                   ],
                //                 )
                //       ),
                //     ),
                //   ],
                // ),
                //
                // ylwDivider(),

                /// browse_images
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        'Images'.tr,
                        style: const TextStyle(
                          fontSize: 25,
                          color: normalTextCol,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: TextButton(
                        style: blueStyle,
                        onPressed: () async {
                          PickedFile img = await showImageChoiceDialog();
                          imgsCtr.updateImages(img);
                        },
                        child: Text(
                          "Add".tr,
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                /// images_list
                (imgsCtr.imageFileList!.isNotEmpty || imgsCtr.imagesUrl.isNotEmpty) ?
                  Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 0.0, top: 0.0),
                            child: SizedBox(
                              height: 100,
                              child: Container(
                                child: (imgsCtr.imageFileList!.isNotEmpty || imgsCtr.imagesUrl.isNotEmpty)
                                    ? ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imgsCtr.imageFileList!.length + imgsCtr.imagesUrl.length,
                                        itemBuilder: (context, index) {
                                          if (index < imgsCtr.imagesUrl.length) {
                                            return imgsCtr.singleImageSaved( imgsCtr.imagesUrl, index);
                                          } else {
                                            return imgsCtr.singleImage(imgsCtr.imageFileList!, index - (imgsCtr.imagesUrl.length));
                                          }
                                        })
                                    : Center(
                                        child: Text('no chosen images'.tr),
                                      ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            );
        });
  }
}
Future<PickedFile>  showImageChoiceDialog()async  {

  Future<PickedFile> selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(
      source: source,
    );
    Get.back();
    return pickedFile!;
  }

  PickedFile? image ;

  await  showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) {
        return AlertDialog(
          backgroundColor: dialogBgCol,
          title:  Text(
            "Choose source",
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Divider(
                  height: 1,
                ),
                ListTile(
                  onTap: () async{
                    image = await selectImage(ImageSource.gallery);
                  },
                  title: Text("Gallery"),
                  leading: const Icon(
                    Icons.image,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  onTap: () async {
                    image = await selectImage(ImageSource.camera);
                  },
                  title: Text("Camera"),
                  leading: const Icon(
                    Icons.camera,
                  ),
                ),
              ],
            ),
          ),
        );
      });


  return image!;

}
