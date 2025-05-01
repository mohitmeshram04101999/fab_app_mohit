
import 'dart:convert';

import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/models/notification_responce_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier
{

  bool _loading = true;
  bool _loadingMore = true;
  int _page = 1;
  int _notitfcationCount = 0;
  List<NotificationDataModel> _data=[];


  bool get loading =>_loading;
  bool get loadingMore =>_loadingMore;
  int get page =>_page;
  List<NotificationDataModel> get data =>_data;
  int get count =>_notitfcationCount;

  getNotification(BuildContext context) async
  {

    _page = 1;
    _data = [];

    _loading = true;

    var user = await DB().getUser();

    var resp = await AuthApi().getNotification(user?.user?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _dt = NotificationResponceModel.fromJson(d);
        _data = _dt.data??[];
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

    _loading = false;
    notifyListeners();

}


  getNotificationCount(BuildContext context) async
  {



    var user = await DB().getUser();

    var resp = await AuthApi().getNotificationCount(user?.user?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        _notitfcationCount = d['count']??0;
        // notifyListeners();
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