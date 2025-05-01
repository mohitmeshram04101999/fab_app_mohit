

import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/models/getCompanmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetCompanyProvider with ChangeNotifier
{

  bool _loading = true;
  Company? _data;

  bool get loading =>_loading;
  Company?  get data =>_data;

  getCompany(BuildContext context) async
  {

    _loading = true;

    var resp = await BusinessApis().getCompany();

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = GetCompanyResponceModel.fromJson(d);
        _data = _da.data;

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

    _loading =  false;
    notifyListeners();

  }



}