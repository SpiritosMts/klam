import 'package:klam/bindings.dart';
import 'package:klam/generalLayout/generalLayoutCtr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/event.dart';
import '../models/user.dart';
import '../myUi.dart';
import '../styles.dart';

class MeetingsList extends StatefulWidget {
  const MeetingsList({super.key});

  @override
  State<MeetingsList> createState() => _MeetingsListState();
}

class _MeetingsListState extends State<MeetingsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgCol,
      child: GetBuilder<LayoutCtr>(builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  child:layCtr.upcomingMeetings.isNotEmpty? ListView.builder(
                    //  physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                        right: 0,
                        left: 0,
                      ),
                      //itemExtent: 100,// card height
                      itemCount: layCtr.upcomingMeetings.length,
                      itemBuilder: (BuildContext context, int index) {
                        Meeting usr = (layCtr.upcomingMeetings[index]);
                        return meetingCard(usr, index,tappable: true);
                      }
                  ):Center(child: Text('No meetings to show',style: TextStyle(fontSize: 16)),),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
