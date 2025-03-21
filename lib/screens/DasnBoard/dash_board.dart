import 'package:fab_app/componenet/customBottomeNavigationBar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/screens/DasnBoard/Home/HomeScreen.dart';
import 'package:fab_app/screens/auth%20screesn/login_in_screen.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageController controller = PageController();
  int crIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          HomeScreen(),
          Container(color: Colors.red),
          Container(color: Colors.yellow),
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
            icon: Image.asset(
              "assets/navigationicons/home.png",
              color: Colors.grey.shade500,
              height: SC.from_width(25),
            ),
            activeIcon: Image.asset(
              "assets/navigationicons/home.png",
              color: AppConstant.primaryColor,
              height: SC.from_width(25),
            ),
            label: "home",
          ),

          //
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigationicons/profileFix.png",
              color: Colors.grey.shade500,
              height: SC.from_width(25),
            ),
            activeIcon: Image.asset(
              "assets/navigationicons/profileFix.png",
              color: AppConstant.primaryColor,
              height: SC.from_width(25),
            ),
            label: "profile",
          ),

          //
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigationicons/market.png",
              color: Colors.grey.shade500,
              height: SC.from_width(25),
            ),
            activeIcon: Image.asset(
              "assets/navigationicons/market.png",
              color: AppConstant.primaryColor,
              height: SC.from_width(25),
            ),
            label: "Marketing",
          ),

          //
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/navigationicons/setting.png",
              color: Colors.grey.shade500,
              height: SC.from_width(25),
            ),
            activeIcon: Image.asset(
              "assets/navigationicons/setting.png",
              color: AppConstant.primaryColor,
              height: SC.from_width(25),
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
