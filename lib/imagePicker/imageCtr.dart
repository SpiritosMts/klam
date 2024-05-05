import 'dart:async';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/widgets.dart' as wig;
import 'package:shimmer/shimmer.dart';
import '../firebaseVoids.dart';
import '../myVoids.dart';
import '../styles.dart';

class ImagePickerCtr extends GetxController {
  //for add garage
  PickedFile? imageFile;
  List<PickedFile>? imageFileList = [];

  //for edit garage
  String docID = '';
  bool adverted = false;
  String logoUrl = '';// saved logo url in fb
  List<dynamic> imagesUrl = [];// saved imgs urls in fb

  //if logo found 'false'
  bool logoDeleted = true;

  @override
  void onInit() {

  }

  clearImageFile() {
    imageFile = null;
    update();
  }
  updateCtr() {
    update();
  }

  //update multi-images
  updateImages(image){
    if(image != null){
      imageFileList!.add(image!);
      print('## <${imageFileList!.length}> image choosen');
      update();
    }
  }
  //update one-image
  updateImage(image){
    if(image != null){
      imageFile = image!;
      print('## logo choosen');
      update();
    }
  }
  // new added images
  singleImage(List imageFileList, index) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Card(
            color: cardColor,

            child: imageFileList.isNotEmpty
                ? Center(
                    child: wig.Image.file(
                      File(imageFileList[index].path),
                      fit: BoxFit.cover,
                      width: 150,
                    ),
                  )
                : Container(),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.grey,
              splashRadius: 1,
              onPressed: () {
                imageFileList.removeAt(index);
                update();
              },
            ),
          ),
        ],
      ),
    );
  }
  // images in fb


  singleImageSaved(List imageFileList, index) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Card(
            color: cardColor,

            child: imageFileList.isNotEmpty
                ? Center(
                    child: shimmerImage(
                        imageFileList[index],
                        w:150
                    )
                  )
                : Container(),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.redAccent,
              splashRadius: 1,
              onPressed: () {
                proposeDeleteImgFromImages(docID, imageFileList, index);
              },
            ),
          ),
        ],
      ),
    );
  }



  proposeDeleteLogo(id) {
    showNoHeader().then((toDelete) {
      if (toDelete) {
        logoDeleted = true;

        ///delete from storage
        deleteFileByUrlFromStorage(logoUrl);

        ///delete from cloud
        updateFieldInFirestore(donationsCollName,id,'logo', '' );
        update();
      }
    });
  }

  proposeDeleteImgFromImages(id,imageFileList, index) async {
    bool delete = await showNoHeader(txt: 'are you sure you want to delete this image ?'.tr);
    if(!delete) return;
    ///delete from storage
    deleteFileByUrlFromStorage(imageFileList[index]);

    ///delete from cloud
    removeElementsFromList([imageFileList[index]], 'images', id, 'requests');

    ///delete image from dialog
    imageFileList.remove(imageFileList[index]);
    update();
  }
  /// upload logo if added & images to fb
  Future<void> uploadAllImages(coll,id) async {
    // add empty string if logo not chosen
     String url = await uploadOneImgToFb('requests/$id/logo', imageFile);
    if (logoDeleted) {
      coll.doc(id).update(
        {
          'logo': url,
          //'images':[],
        },
        // SetOptions(merge: true),
      );
    }
    ///images

    List<String>? urls = [];
    if (imageFileList!.isNotEmpty) {
      print('### found new images to add');
      for (int i = 0; i < imageFileList!.length; i++) {
        var url = await uploadOneImgToFb('requests/$id/images', imageFileList![i]);
        urls.add(url);
      }
    }
    //if there is saved images zid alehom sinn add new
    if (imagesUrl.isNotEmpty) {
      print('### found old images to merge with new if found');
      addElementsToList(urls, 'images', id, 'requests');
    } else {
      coll.doc(id).update(
        {
          'images': urls,
        },
        //SetOptions(merge: true),
      );
    }
  }

  Widget  shimmerImage(url,{double h=300,double w=300}){
    return FancyShimmerImage(
      shimmerDirection: ShimmerDirection.ltr,
      //boxFit: BoxFit.cover,
      width: w,
      height: h,
      imageUrl: url,
      shimmerBaseColor: blueCol80 ,
      shimmerHighlightColor: yellowCol.withOpacity(0.2),
      shimmerBackColor: blueCol80,
      boxFit: BoxFit.cover,
      errorWidget: noSpecificImage(),
    );
  }
  Widget noSpecificImage(){
    return Image.asset('assets/logo.png',color: yellowCol.withOpacity(0.5));
  }

}
