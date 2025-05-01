import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/internetProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  bool nertworkError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    start();
  }

  start() async
  {


    Provider.of<InterNetProvider>(context,listen: false).init();

    var c = await Connectivity().checkConnectivity();


    print("From splash Screen $c");
    if(c[0]==ConnectivityResult.none)
      {
        nertworkError = true;
        showSnakeBar(context, message: "N0 Internet");
        Connectivity().onConnectivityChanged.listen((event) {
          if(event[0]==ConnectivityResult.none)
            {

            }
          else
            {
              start();
            }
        },);
        return ;
      }
    else
      {



        await Future.delayed(Duration(seconds: 3));
        Provider.of<AuthProvider>(context,listen: false).checkUser(context);

      }


  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SC.from_width(91)),
          child: Image.asset("assets/auth_image/splashScreen.png"),
        ),
      ),

    );
  }
}
