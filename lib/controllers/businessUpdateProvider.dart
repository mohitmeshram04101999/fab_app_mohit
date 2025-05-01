

import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BusinessUpdateProvider with ChangeNotifier
{

  BusinessModel? _business;
  String? _googleToken;

  setBusiness(BusinessModel b,String g)
  {
    _business = b;
    _googleToken = g;

  }


  Future updateBusiness(BuildContext context,
  {
    String? primaryPhone,
  }) async
  {

    print("Update Profile");

    var resp  = await BusinessApis().updateBusiness(
        businessId: _business?.id??'',
        googleToken: _googleToken??'',
      primaryPhone: primaryPhone,
    );


    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);


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

  }

}