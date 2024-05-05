// rate teacher
// teacher files

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bindings.dart';
import '../generalLayout/generalLayoutCtr.dart';
import '../models/file.dart';
import '../myUi.dart';
import '../myVoids.dart';
import '../styles.dart';

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({super.key});

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutCtr>(
        initState: (_){
          Future.delayed(const Duration(milliseconds: 400), () {

            print('## TeacherDetails initState "start streaming" ');

          });


        },
        dispose: (_){
          print('## TeacherDetails dispose "stop streaming" ');
          Future.delayed(const Duration(milliseconds: 50), () {

          });

        },
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBarBgColor,
              title: Text(
                'Teacher Info',style: TextStyle(
                fontWeight: FontWeight.w500,
                color: appBarTitleColor,
              ),
              ),
              bottom: appBarUnderline(),
              leading:IconButton(
                icon: Icon(Icons.arrow_back_outlined,color: appBarNotificationBellColor,),
                onPressed: () {
                  Get.back();
                },
              ),
            ),

            body: Container(
              color: bgCol,
              child:  Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      layCtr.selectedTeacher.name, // Replace with actual name
                      style: TextStyle(
                        color: normalTextCol,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RandomAvatar(
                          DateTime.now().toIso8601String(),
                        height: 80,
                        width: 80,
                       ),
                          SizedBox(width: 20.0),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Rating:',
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    color: normalTextCol.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                RichText(
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '${layCtr.selectedTeacher.rating}',
                                      style: GoogleFonts.almarai(
                                        fontSize: 26.sp,
                                        color: blueCol.withOpacity(0.8),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(text: ' '),

                                  ]),
                                ),
                                SizedBox(height: 5.0),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 10,left: 20,top: 10),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        text: TextSpan(children: [
                          if (true)
                            TextSpan(
                                text: 'about:',
                                style: GoogleFonts.almarai(
                                  height: 1,
                                  textStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
                                )),
                          TextSpan(
                              text: '  i am a teacher at the Higher School of Communication (SupCom)',

                              style: GoogleFonts.almarai(
                                height: 1.2,
                                textStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              )),

                        ]),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    CustomDivider(
                      text: '  Docs (${layCtr.allFiles.length}) ',
                    ),
                    SizedBox(height: 20,),
                    layCtr.allFiles.isEmpty?Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(child: Text('No docs to show', style: TextStyle(
                            fontSize: 17
                        ),),)): Expanded(
                      child: Container(
                        child: ListView.builder(
                          //  physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 20,
                              right: 0,
                              left: 0,
                            ),
                            //itemExtent: 100,// card height
                            itemCount: layCtr.allFiles.length,
                            itemBuilder: (BuildContext context, int index) {
                              FileCard ev = (layCtr.allFiles[index]);
                              return fileCrd(ev, index);
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.orange,
            height: 3,
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.orange,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.orange,
            height: 3,
            thickness: 2,

          ),
        ),
      ],
    );
  }
}
