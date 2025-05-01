import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/more_key_words_model.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:flutter/material.dart';



class KeyWordDetailProvider with ChangeNotifier
{
  BusinessModel? _business;
  User? _user;
  final _api = BusinessApis();
  List<MoreKeyword> _moreKeyWords = [];
  bool _loadingKeyWords = true;
  bool _loadingKeyWordsMore = false;
  int _page = 1;



  List<MoreKeyword> get moreKeyWords =>_moreKeyWords;
  bool get loadingKeyWords => _loadingKeyWords;
  bool get loadingKeyWordsMore => _loadingKeyWordsMore;
  User? get user=>_user;

  upDate()=>notifyListeners();

  setUser(User user)
  {
   _user = user;
  }
  setBusiness(BusinessModel business)
  {
    _business = business;
  }

  clear()
  {
    _moreKeyWords = [];
    _loadingKeyWordsMore = false;
    _loadingKeyWords = true;
    _page = _page;
  }

  getMoreKeyWord(BuildContext context)async
  {
    clear();
    _loadingKeyWords = true;
    var resp = await _api.getKeyWordDetail(businessId: _business?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        MoreKeyWordsResponceModel data = MoreKeyWordsResponceModel.fromJson(d);
        _moreKeyWords = data.moreKeywords??[];
        if(data.moreKeywords!.isNotEmpty)
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

    _loadingKeyWords = false;
    notifyListeners();

  }


  loadMoreMoreKeyWord(BuildContext context)async
  {
    _loadingKeyWords = true;
    notifyListeners();
    var resp = await _api.getKeyWordDetail(businessId: _business?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        MoreKeyWordsResponceModel data = MoreKeyWordsResponceModel.fromJson(d);
        if(data.moreKeywords!.isNotEmpty)
          {
            _moreKeyWords.addAll(data.moreKeywords??[]);
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

    _loadingKeyWords = false;
    notifyListeners();

  }

}