import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klam/models/club.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../main.dart';
import '../bindings.dart';
import '../firebaseVoids.dart';
import '../models/event.dart';
import '../models/doantion.dart';
import '../models/file.dart';
import '../models/user.dart';
import '../myUi.dart';
import '../myVoids.dart';
import '../styles.dart';
import 'package:uuid/uuid.dart';

class LayoutCtr extends GetxController {
  String appBarText ='';//appbar title
  String messageToSend ='';
  List<Widget> appBarBtns=[];

  @override
  onInit() {
    super.onInit();
    print('## ## init LayoutCtr');
    Future.delayed(const Duration(milliseconds: 50), ()  async {

    });
  }
  /// *************************************************************************************

  updateAppbar({String? title,List<Widget>? btns}){
    if(title!=null) appBarText = title;
    if(btns!=null) appBarBtns=btns;
    update();
  }
  onScreenSelected(int index){
    bool isStudent = cUser.role==authCtr.roles[0];
    switch (index) {

      case 0:
        updateAppbar(title:isStudent?'Upcoming meets' :'Schedule meet',btns:isStudent? [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cUser.name,style: TextStyle(color: blueCol),),
              ),
            ],
          )

        ]:[
          GestureDetector(
            onTap: () {
              showAnimDialog(addMeetingDialog());

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: appBarButtonsCol,
                ),
              ),
            ),
          ),


        ]);

        update();
        break;

      case 1:
        updateAppbar(title:isStudent? 'Top teaches':'Add Document',btns:isStudent? [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cUser.name,style: TextStyle(color: blueCol),),
              ),
            ],
          )

        ]:[
          GestureDetector(
            onTap: () {
              showAnimDialog(layCtr.addEventDialog());

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: appBarButtonsCol,
                ),
              ),
            ),
          ),

        ]);

        update();

        break;

      case 2:
        updateAppbar(title:cUser.isAdmin? 'Add Donation':'Add Donation',btns: cUser.isAdmin? []:[]);
        update();

        break;




    }


  }

  addMeetingDialog() {
    return AlertDialog(
      backgroundColor: dialogBgCol,
      title: Text('Add New Club',
        style: TextStyle(
          color: dialogTitleCol,
        ),),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Form(
          key: addClubKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 20,),

              /// components

              customTextField(
                textInputType: TextInputType.text,
                controller: newClubNameTec,
                labelText: 'Title',
                hintText: '',
                icon: Icons.title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "name can't be empty";
                  }


                  return null;

                },
              ),
              SizedBox(height: 18,),
              customTextField(
                textInputType: TextInputType.text,
                controller: newClubDescTec,
                labelText: 'Description',
                hintText: '',
                icon: Icons.description,
                validator: (value) {

                  return null;

                },
              ),
              SizedBox(height: 18,),
              customTextField(
                textInputType: TextInputType.text,
                controller: newClubDescTec,
                labelText: 'Time',
                hintText: '',
                icon: Icons.timelapse,
                validator: (value) {

                  return null;

                },
              ),
              SizedBox(height: 18,),






              /// buttons
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //cancel
                    TextButton(
                      style: borderBtnStyle(),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: dialogBtnCancelTextCol),
                      ),
                    ),
                    //add
                    TextButton(
                      style: filledBtnStyle(),
                      onPressed: () async {
                        if(addClubKey.currentState!.validate()){
                          //addClubToDB();
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: dialogBtnOkTextCol ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// *************************************************************************************


  //event +
  GlobalKey<FormState> addClubKey = GlobalKey<FormState>();
  final newClubNameTec = TextEditingController();
  final newClubDescTec = TextEditingController();
  PickedFile? newItemImage;
  deleteImage() {
    newItemImage = null;
    update();
  }
  updateImage(image){
    if(image != null){
      newItemImage = image!;
      update();
    }
  }

  //club +
  GlobalKey<FormState> addEventKey = GlobalKey<FormState>();
  final newEventTitleTec = TextEditingController();
  final newEventDescTec = TextEditingController();


  List<Club> selectedClubs = [];
  List<ScUser> selectedUsers = [];

  ScUser selectedTeacher = ScUser();
  selectTeacher(ScUser teacher){

    selectedTeacher = teacher;

    update();

  }

  List<ScUser> allTeachers =[];///+++++++++++++++++++++++++++++++
  List<FileCard> allFiles = [];///+++++++++++++++++++++++++++++++
  List<Meeting> upcomingMeetings = [];///+++++++++++++++++++++++++++++++

  List<Club> allClubs =[];
  List<JoinRequest> allRequests =[];







  Future<bool> alreadySentReq() async {

    QuerySnapshot querySnapshot = await donationsColl
        .where('studentID', isEqualTo: cUser.id)  // Check for the field 'studentID' with value '123'
        .where('clubToJoinID', isEqualTo: 'selectedClub.id')  // Check for the field 'clubToJoinID' with value '456'
        .get();

    // Check if there are any documents that match the conditions
    if (querySnapshot.docs.isNotEmpty) {
      print('Document found with specified conditions');

      return true;

    } else {
      print('No document found with specified conditions');
      return false;

    }
  }
  /// Requests
  Future<void> refreshDonations() async {
    allRequests = await getAlldocsModelsFromFb<JoinRequest>(
        true, donationsColl, (json) => JoinRequest.fromJson(json),
        localKey: '');
    update();
  }

  addDonation()async{


    if(await alreadySentReq()){
      showTos('You already sent a join request... Please wait for approvement',color: Colors.black87);
      return;
    }

    bool accept = false;
     accept = await showNoHeader(txt: 'are you sure you want to request to join "" ?',btnOkText: 'Send Request');
    if(!accept) {
      return;
    }


    JoinRequest newReq = JoinRequest(
      clubToJoinID: 'selectedClub.id',
      clubToJoinName: 'selectedClub.name',
      studentID: cUser.id,
      studentName: cUser.name,
      date: todayToString(showHoursNminutes: true),


    );
    try{
      String specificID = Uuid().v1();
      var value = await addDocument(
        specificID: specificID,
        fieldsMap: newReq.toJson(),
        coll: donationsColl,

      );
      Get.back(); //hide loading
      showTos('Your join request has been sent!',color: Colors.green);

    }catch  (err){
      print('## cant create request  : $err');
    }

  }


  addEventDialog() {
    return AlertDialog(
      backgroundColor: dialogBgCol,
      title: Text('Add New Event',
        style: TextStyle(
          color: dialogTitleCol,
        ),),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {

          return SizedBox(
            //height: 100.h / 1.7,
            width: 100.w,
            child: AddEvDia(),
          );
        },
      ),
    );
  }



}

///Add event dialog
class AddEvDia extends StatefulWidget {
  const AddEvDia({super.key});

  @override
  State<AddEvDia> createState() => _AddEvDiaState();
}
class _AddEvDiaState extends State<AddEvDia> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LayoutCtr>(

        builder: (ctr) => SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Form(
            key: layCtr.addEventKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20,),

                /// title

                customTextField(
                  textInputType: TextInputType.text,
                  controller: layCtr.newEventTitleTec,
                  labelText: 'Title',
                  hintText: '',
                  icon: Icons.title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "title can't be empty";
                    }


                    return null;

                  },
                ),
                SizedBox(height: 18,),
                customTextField(
                  textInputType: TextInputType.text,
                  controller: layCtr.newEventDescTec,
                  labelText: 'Description',
                  hintText: '',
                  icon: Icons.description,
                  validator: (value) {

                    return null;

                  },
                ),
                SizedBox(height: 18,),

                /// image
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //add image
                    ButtonTheme(
                      buttonColor: dialogBtnOkTextCol,
                      //minWidth: 100.w  / 9,
                      child: ElevatedButton(
                        style: filledBtnStyle(color: dialogBtnOkCol.withOpacity(0.7)),
                        onPressed: () async {
                          PickedFile img = await showImageChoiceDialog();
                          layCtr.updateImage(img);
                        },
                        child: Text('Add File'),
                      ),
                    ),

                    //image_display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: SizedBox(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: SizedBox(
                                  width: 23.w ,
                                  height: 15.w,
                                  //size: Size.fromRadius(30),
                                  child: layCtr.newItemImage != null
                                      ? Image.file(
                                    File(layCtr.newItemImage!.path),
                                    fit: BoxFit.cover,
                                  )
                                      : Container(),
                                ),
                              ),
                            ),

                            ///delete
                            if (layCtr.newItemImage != null)
                              Positioned(
                                top: -11,
                                right: -11,
                                child: IconButton(
                                    icon: const Icon(Icons.close),
                                    color: Colors.grey,
                                    splashRadius: 1,
                                    onPressed: () {
                                      layCtr.deleteImage();
                                    }),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),




                /// buttons
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //cancel
                      TextButton(
                        style: borderBtnStyle(),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: dialogBtnCancelTextCol),
                        ),
                      ),
                      //add
                      TextButton(
                        style: filledBtnStyle(),
                        onPressed: () async {
                          if(layCtr.addEventKey.currentState!.validate()){
                            //layCtr.addEventToDB();
                          }
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(color: dialogBtnOkTextCol ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}
