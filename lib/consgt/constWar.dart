
import 'dart:ui';

import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant
{

  static Color primaryColor =  Color.fromRGBO(110, 163, 243, 1);


  static BoxDecoration customButtonDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    );
  }

  static TextStyle labelStyle2(BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: AppConstant.primaryColor,
      fontSize: SC.from_width(16)
  );

  static TextStyle labelStylTextField (BuildContext)=>TextStyle(
    fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: SC.from_width(16)
  );


  static TextStyle labelStyl (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: SC.from_width(20)
  );

  static TextStyle infoTextLabel (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontSize: SC.from_width(14),
      color: Colors.black,
      fontWeight: FontWeight.w400);


  static TextStyle richInfoTextLabel (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontSize: SC.from_width(13),
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static TextStyle bodyText (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontSize: SC.from_width(13),
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static TextStyle richInfoTextLabel2 (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontSize: SC.from_width(12),
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static TextStyle buttonTExtStyle (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontSize: SC.from_width(16),
      color: Colors.white,
      fontWeight: FontWeight.w500);


  static TextStyle font_500_14 (BuildContext)=>TextStyle(
      fontFamily: 'Poppins',
      fontSize: SC.from_width(14),
      color: Colors.black,
      fontWeight: FontWeight.w500);




}