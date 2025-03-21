import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/screens/auth%20screesn/login_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SC.getScreen(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dhanda Al Marketing App',
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.white,

        bottomNavigationBarTheme: BottomNavigationBarThemeData(



          selectedLabelStyle: TextStyle(
            color: Colors.red
          ),
        ),


        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: SC.from_width(20),
            color: Colors.black,
            fontWeight: FontWeight.w600
          )
        ),


        listTileTheme: ListTileThemeData(

          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: SC.from_width(14),
              color: Colors.black
          ),

          subtitleTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
            fontSize: SC.from_width(16)
          )
        ),

        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 3,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(





          hintStyle: AppConstant.labelStylTextField(BuildContext),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(width: 1)
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1,color: AppConstant.primaryColor)
          )

        ),

        colorScheme: ColorScheme.light(


          primary: Color.fromRGBO(110, 163, 243, 1)

        )




      ),
      home: LogInScreen(),
    );
  }
}

