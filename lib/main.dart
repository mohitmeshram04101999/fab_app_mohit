import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/BusinessServiceProvider.dart';
import 'package:fab_app/controllers/NotificatonProvider.dart';
import 'package:fab_app/controllers/ai_providerapi.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/businessControllers.dart';
import 'package:fab_app/controllers/businessUpdateProvider.dart';
import 'package:fab_app/controllers/compitetor_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/controllers/getcompinany%20Controller.dart';
import 'package:fab_app/controllers/googleReviewprovider.dart';
import 'package:fab_app/controllers/google_report_detail_provider.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/controllers/homeScreenDetailProvider.dart';
import 'package:fab_app/controllers/internetProvider.dart';
import 'package:fab_app/controllers/mediaProvider.dart';
import 'package:fab_app/controllers/plan_provider.dart';
import 'package:fab_app/controllers/porductProvider.dart';
import 'package:fab_app/controllers/postPorovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/screens/auth%20screesn/login_in_screen.dart';
import 'package:fab_app/screens/auth%20screesn/splashScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => BusinessProvider()),
      ChangeNotifierProvider(create: (_) => CurruntBusinessProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => KeyWordDetailProvider()),
      ChangeNotifierProvider(create: (_) => CompetitorDetailProvider()),
      ChangeNotifierProvider(create: (_) => AiProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => MediaProvider()),
      ChangeNotifierProvider(create: (_) => BusinessUpdateProvider()),
      ChangeNotifierProvider(create: (_) => BusinessServiceProvider()),
      ChangeNotifierProvider(create: (_) => GoogleReportDetailProvider()),
      ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ChangeNotifierProvider(create: (_) => GetCompanyProvider()),
      ChangeNotifierProvider(create: (_) => PlanProvider()),
      ChangeNotifierProvider(create: (_) => InterNetProvider()),
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SC.getScreen(context);

    return MaterialApp(
      key: Provider.of<InterNetProvider>(context,listen: false).key,
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
          titleTextStyle: GoogleFonts.poppins(
            fontSize: SC.from_width(20),
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
          elevation: 5,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.grey.shade50.withOpacity(.3),
        ),
        
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),


          side: BorderSide(
            width: 2,
            color: Colors.grey
          )
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 1,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SC.from_width(100))
          )
        ),

        listTileTheme: ListTileThemeData(

          titleTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: SC.from_width(16),
              color: Colors.black
          ),

          subtitleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
            fontSize: SC.from_width(14)
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





          hintStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),

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
      home: SplashScreen(),
    );
  }
}

