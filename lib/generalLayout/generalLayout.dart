import 'package:klam/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../a_screens/donation/addDonation.dart';
import '../a_screens/seeMeetings.dart';
import '../a_screens/teachersList.dart';

import '../bindings.dart';
import '../styles.dart';
import 'generalLayoutCtr.dart';

class GeneralLayout extends StatefulWidget {
  const GeneralLayout({super.key});

  @override
  State<GeneralLayout> createState() => _GeneralLayoutState();
}

class _GeneralLayoutState extends State<GeneralLayout> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return   [ //student
    MeetingsList(), //my clubs
    TeachersList(), //other clubs
    DonationAdd(),

    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.groups),
        title: ("meetings"),

        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.file_copy),
        title: ("docs"),
        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book),
        title: ("donation"),
        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutCtr>(
        initState: (_) {},
        dispose: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appBarBgColor,
            title: Text(
              layCtr.appBarText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: appBarTitleColor,
             ),
            ),
            bottom: appBarUnderline(),
            leading:IconButton(
              icon: Icon(Icons.logout,color: appBarNotificationBellColor,),
              onPressed: () {
                authCtr.signOutUser(shouldGoLogin: true);

                //test
                // ntfCtr.sendPushMessage(
                //   receiverToken:cUser.deviceToken,
                //   title: 'selectedClub.name',
                //   body: 'messageToSend',
                // );
              },
            ) ,
            actions: layCtr.appBarBtns,
          ),
          body: PersistentTabView(
            selectedTabScreenContext: (ctx){

            },
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: navBarBgColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            hideNavigationBar: false,
            bottomScreenMargin: 55,
            navBarHeight: 55,

            onItemSelected:layCtr.onScreenSelected,
            navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
          ),
        );
      }
    );
  }
}
