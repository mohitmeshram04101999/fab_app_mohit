


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/packageScreens/all_plan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InterNetProvider with ChangeNotifier
{

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final Connectivity _connectivity = Connectivity();
  bool _dialogOpen = false;

  bool _noEnternet = true;
  bool get noEnternet => _noEnternet;

  GlobalKey<ScaffoldMessengerState> get key => _scaffoldMessengerKey;

  init()
  {
    _connectivity.onConnectivityChanged.listen((event) {
      BuildContext? context = key.currentContext;
      if(context!=null)
        {
          hendelConection(context,event);
        }
    },);
  }

  hendelConection(BuildContext context,List<ConnectivityResult> c)
  {

    if(c[0]==ConnectivityResult.none)
      {
        _noEnternet = true;
        notifyListeners();
      }
    else
      {
        _noEnternet = false;
        notifyListeners();
      }

    print('Enter nat state $_noEnternet  change $c');
  }


}