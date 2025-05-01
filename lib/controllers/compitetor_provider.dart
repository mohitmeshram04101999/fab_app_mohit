import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/home_responce_model.dart';
import 'package:fab_app/models/more_compi_responce_model.dart';
import 'package:fab_app/models/more_key_words_model.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:flutter/material.dart';



class CompetitorDetailProvider with ChangeNotifier
{
  BusinessModel? _business;
  final _api = BusinessApis();
  List<CompetitorAnalysis> _comp = [];
  bool _loading = true;
  bool _loadingMore = false;
  Subscription? _subscription;
  int _page = 1;



  List<CompetitorAnalysis> get competitor =>_comp;
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;
  Subscription? get subscription =>_subscription;



  upDate()=>notifyListeners();

  setUser(User user)
  {
    _subscription  = user.subscription;
  }

  setBusiness(BusinessModel business)
  {
    _business = business;
  }

  clear()
  {
    _comp = [];
    _loading = false;
    _loadingMore = true;
    _page = _page;
  }

  getData(BuildContext context)async
  {
    clear();
    _loading = true;
    var resp = await _api.getCompetitorDetail();

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        print("Model is genrated");
        MoreCompWordsResponceModel data = MoreCompWordsResponceModel.fromJson(d);
        print("Model is genrated");
        _comp = data.data??[];
        if(data.data!.isNotEmpty)
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


  getMoreData(BuildContext context)async
  {
    _loadingMore = true;
    var resp = await _api.getKeyWordDetail(businessId: _business?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);

        MoreCompWordsResponceModel data = MoreCompWordsResponceModel.fromJson(d);
        print("Model is genrated");
        if(data.data!.isNotEmpty)
        {
          _comp.addAll(data.data??[]);
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