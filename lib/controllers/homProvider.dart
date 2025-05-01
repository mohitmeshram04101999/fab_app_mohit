
import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/models/home_responce_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier
{

  HomeResponceModel? _homeData;
  bool _loading = true;

  HomeResponceModel? get homeData =>_homeData;
  bool get loading => _loading;


  clear()
  {
    _loading = false;
    // _homeData = null;
  }

  getHomeData(BuildContext context)async
  {
    var auth = Provider.of<AuthProvider>(context,listen: false);
    var curruntBusinessProvider = Provider.of<CurruntBusinessProvider>(context,listen: false);
    var resp = await BusinessApis().getDashBoard(googleToken: auth.googleToken, businessId: curruntBusinessProvider.curruntBusiness?.id??'' );


    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        _homeData = HomeResponceModel.fromJson(d);

        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, resp.body);
        break;


      default:
        break;
    }

    _loading = false;
    notifyListeners();
  }

}