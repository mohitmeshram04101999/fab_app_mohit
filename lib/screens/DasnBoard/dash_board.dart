import 'dart:async';

import 'package:fab_app/componenet/customBottomeNavigationBar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/NotificatonProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/Home/HomeScreen.dart';
import 'package:fab_app/screens/Home_sub_screens/notificationscreen.dart';
import 'package:fab_app/screens/auth%20screesn/login_in_screen.dart';
import 'package:fab_app/screens/marketing_Screens/markiting_screen.dart';
import 'package:fab_app/screens/profileScreens/profile_screen.dart';
import 'package:fab_app/screens/setting_screen/setting%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageController controller = PageController();
  int crIndex = 0;
  var color = Colors.red;
  int backPress =0;


  @override
  Widget build(BuildContext context) {





    return WillPopScope(
      onWillPop: () async{
        if(crIndex==0)
          {
            if(backPress==2)
              {
                return true;
              }
            else
              {
                backPress++;
                Timer(Duration(seconds: 3),(){backPress=0;});
              }
          }
        else
          {
            crIndex = 0;
            controller.jumpToPage(0);
            setState(() {

            });
          }
        return false;
      },
      child: MyScaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.grey.shade50.withOpacity(.3),
          leading: Padding(
            padding: EdgeInsets.only(left:SC.from_width(7) ),
            child: Image.asset("assets/auth_image/pabLogo.png"),
          ),

          actions: [
            Padding(
              padding:  EdgeInsets.only(right:SC.from_width(12) ),
              child: Ink(
                width: SC.from_width(40),
                height: SC.from_width(40),
                child: Stack(
                  children: [
              
              
                    Center(
                      child: InkWell(onTap: (){
                        RouteTo(context, child: (p0, p1) => NotificationScreen(),);
                      }, child: Icon(Icons.notifications,color: AppConstant.primaryColor,)),
                    ),




                    FutureBuilder(future: Provider.of<NotificationProvider>(context,listen: false).getNotificationCount(context), builder: (context, snapshot) {



                      return Consumer<NotificationProvider>(
                          builder: (context, p, child)

                          {

                            if(p.count>0)
                            {
                              return Positioned(
                                top: SC.from_width(5),
                                right: SC.from_width(5),
                                child: Container(
                                  height: SC.from_width(15),
                                  width: SC.from_width(15),
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle
                                  ),
                                  child: FittedBox(child: Text('${p.count>99?'+99':'${p.count}'}'
                                    ,style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.white),)),
                                ),
                              );
                            }


                            return SizedBox();

                          });

                    },)
              

                  ],
                ),
              ),
            )
          ],

          titleSpacing: 0,

          title: Padding(
            padding: EdgeInsets.only(top: SC.from_width(15)),
            child: Image.asset("assets/auth_image/visitingText.png",height: SC.from_width(25),),
          ),

        ),

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            HomeScreen(),
            ProfileScreen(),
            MarkitingScreen(),
            SettingScreen(),
          ],
        ),

        bottomNavigationBar: CustomBottomNavigationBar(
          curruntIndex: crIndex,

          onChange: (d) {
            crIndex = d;
            controller.jumpToPage(d);
            setState(() {});
          },

          items: [
            //
            BottomNavigationBarItem(
              icon: Cover(
                l: SC.from_width(-5),
                r: SC.from_width(-5),
                child: Image.asset(
                  "assets/navigationicons/home.png",
                  color: Colors.grey.shade500,
                  height: SC.from_width(25),
                  fit: BoxFit.fitWidth,
                ),
              ),
              activeIcon: Cover(
                l: SC.from_width(-5),
                r: SC.from_width(-5),
                child: Image.asset(
                  "assets/navigationicons/home.png",
                  color: AppConstant.primaryColor,
                  fit: BoxFit.fitWidth,
                  height: SC.from_width(25),
                ),
              ),
              label: "Home",
            ),

            //
            BottomNavigationBarItem(
              icon: Cover(

                child: Image.asset(
                  "assets/navigationicons/profileFix.png",
                  color: Colors.grey.shade500,
                  height: SC.from_width(25),
                ),
              ),
              activeIcon: Cover(
                child: Image.asset(
                  "assets/navigationicons/profileFix.png",
                  color: AppConstant.primaryColor,
                  height: SC.from_width(25),
                ),
              ),
              label: "Profile",
            ),

            //
            BottomNavigationBarItem(
              icon: Cover(
                l: SC.from_width(-5),
                r: SC.from_width(-5),
                child: Image.asset(
                  "assets/navigationicons/market.png",
                  color: Colors.grey.shade500,
                  height: SC.from_width(25),
                  fit: BoxFit.fitWidth,
                ),
              ),
              activeIcon: Cover(
                l: SC.from_width(-5),
                r: SC.from_width(-5),
                child: Image.asset(
                  "assets/navigationicons/market.png",
                  color: AppConstant.primaryColor,
                  height: SC.from_width(25),
                  fit: BoxFit.fitWidth,
                ),
              ),
              label: "Marketing",
            ),

            //
            BottomNavigationBarItem(
              icon: Cover(
                child: Image.asset(
                  "assets/navigationicons/setting.png",
                  color: Colors.grey.shade500,
                  height: SC.from_width(25),
                ),
              ),
              activeIcon: Cover(
                child: Image.asset(
                  "assets/navigationicons/setting.png",
                  color: AppConstant.primaryColor,
                  height: SC.from_width(25),
                ),
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
  Widget Cover({ 
    required Widget child,
    double t = 0,
    double d = 0,
    double l = 0,
    double r = 0,
  })
  {
    return Container(
    // color: color,
    width: SC.from_width(25),
    height: SC.from_width(25),
    child: Stack(
      children: [
        Positioned(
          top: t,
            bottom: d,
            left: l,
            right: r,
            child: child),
      ],
    ),
    );
  }
}
