
import 'dart:ui';

import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConstant
{

  static Color primaryColor =  Color.fromRGBO(110, 163, 243, 1);


  static BoxDecoration customButtonDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    );
  }

  static TextStyle labelStylTextField (BuildContext)=>TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: SC.from_width(16)
  );


  static TextStyle labelStyl (BuildContext)=>TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: SC.from_width(20)
  );

  static TextStyle infoTextLabel (BuildContext)=>TextStyle(
      fontSize: SC.from_width(15),
      color: Colors.black,
      fontWeight: FontWeight.w400);


  static TextStyle richInfoTextLabel (BuildContext)=>TextStyle(
      fontSize: SC.from_width(14),
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static TextStyle buttonTExtStyle (BuildContext)=>TextStyle(
      fontSize: SC.from_width(16),
      color: Colors.white,
      fontWeight: FontWeight.w500);




}