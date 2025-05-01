

import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/models/google_detaile_report_responce.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleReportDetailProvider with ChangeNotifier
{

  int _page = 1;
  bool _loading = true;
  bool _loadingMore = false;
  List<GoogleReport> _data = [];
  User? _user;

  bool get loading =>_loading;
  bool get loadingMore =>_loadingMore;
  List<GoogleReport>get data => _data;
  User? get user => _user;


  upDate()=>notifyListeners();

  setUser(User user)
  {
    _user = user;
  }

  clear()
  {
    _page = 1;
    _loading = true;
    _loadingMore =  false;
    _data = [];
  }

  getReport(BuildContext context) async
  {
    var resp = await BusinessApis().getGoogleReportDetail(businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        GoogleReportDetaileModel _d = GoogleReportDetaileModel.fromJson(d);
        _data = _d.data??[];
        if(_data.isNotEmpty)
          {
            _page++;
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

    _loading  = false;
    notifyListeners();

  }


  getMoreReport(BuildContext context) async
  {

    _loadingMore = true;

    var resp = await BusinessApis().getGoogleReportDetail(businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        GoogleReportDetaileModel _d = GoogleReportDetaileModel.fromJson(d);

      if(_d.data!.isNotEmpty)
        {
          _data.addAll(_d.data??[]);
          _page++;
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

    _loadingMore = false;
    notifyListeners();


  }

}