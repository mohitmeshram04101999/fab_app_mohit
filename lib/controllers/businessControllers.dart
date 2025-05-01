



import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessProvider  with ChangeNotifier
{

  List<BusinessModel> _allBusiness = [];
  bool _loadingBusiness = true;


  List<BusinessModel> get allBusiness =>_allBusiness ;
  bool get loading => _loadingBusiness ;



  load(BuildContext context) async
  {

    _loadingBusiness = true;
    var auth = Provider.of<AuthProvider>(context,listen: false);
    var resp;

    resp = await BusinessApis().getAllBusiness(
      userId: auth.user?.user?.id??'',
    );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var data = GetAllBusinessResponceModel.fromJson(d);
        if(data.data !=null &&data.data!.isNotEmpty)
        {
          _allBusiness = data.data??[];
        }

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

    _loadingBusiness = false;
    notifyListeners();


  }


  getAllBusiness(
      BuildContext context,
      {
    required String? token,

})async
  {
    _loadingBusiness = true;
    notifyListeners();

    var auth = Provider.of<AuthProvider>(context,listen: false);
    print("this is google Token $token ${auth.user?.user?.id}");

    var resp = await BusinessApis().getAllBusiness(googleToken: token,userId: auth.user?.user?.id??'',gmail: auth.googleAccount?.email??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var data = GetAllBusinessResponceModel.fromJson(d);
        if(data.data !=null &&data.data!.isNotEmpty)
          {
            _allBusiness = data.data??[];
          }

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

    _loadingBusiness = false;
    notifyListeners();


  }


}