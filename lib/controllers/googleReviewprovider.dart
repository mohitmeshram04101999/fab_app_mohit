

import 'dart:convert';

import 'package:fab_app/api_service/reviewApi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/ai_providerapi.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/get_all_review_model.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/profile_screen_body/replywithScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewProvider with ChangeNotifier
{

  final _api = ReviewApi();
  List<Review> _review = [];
  AverageRating? _averageRating;
  bool _loadin = true;
  bool _loadinMore = false;
  int _page = 1;
  BusinessModel? _business;
  String? _gToken;
  double _reting = 0;


  List<Review> get review =>_review;
  double get rating => _reting;
  bool get loading =>_loadin;
  bool get loadMore =>_loadinMore;
  AverageRating? get averageRating => _averageRating;

  setBusiness(BusinessModel b,String token)
  {
    _business = b;
    _gToken = token;
}

update()
{
  notifyListeners();
}


  List<Review> getFilterData(String type)
{

  List<Review> _d = [];

  if(type == "Replied")
    {
      _review.forEach((element) {
        if(element.response.toString()!='')
          {
            _d.add(element);
          }
      },);
    }
  if(type == "Pending")
  {
    _review.forEach((element) {
      if(element.response.toString()=='')
      {
        _d.add(element);
      }
    },);
  }
  if(type == "All")
  {
    _d.addAll(_review);
  }


  return _d;
}

  getAllReview(BuildContext context) async
  {

    _page = 1;
    _review = [];

    _loadin = true;
    var resp = await _api.getAllReview(businessId:_business?.id??'') ;

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = GetAllReviewResponce.fromJson(d);

        print(d['averageRating']);

        _review = _da.data?.reviews??[];
        _averageRating = _da.averageRating;
        if(_review.isNotEmpty)
          {
            _page++;
          }
        notifyListeners();
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

    _loadin = false;
    notifyListeners();
  }


  editMode(BuildContext context,Review r)
  {
    Provider.of<AiProvider>(context,listen: false).setValue(r.response??'');
    RouteTo(context, child: (p0, p1) => ReplyWithAiScreen(review: r,edit: true,),);

  }



  getMoreReview(BuildContext context) async
  {

    _loadinMore = true;
    notifyListeners();
    var resp = await _api.getAllReview(businessId:_business?.id??'') ;

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = GetAllReviewResponce.fromJson(d);
        if(_da.data!.reviews!.isNotEmpty)
        {
          _review.addAll(_da.data?.reviews??[]);
          _page++;
        }
        notifyListeners();
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

    _loadinMore = false;
    notifyListeners();
  }


  reply(BuildContext context,String reply,Review review) async
  {

    var resp = await _api.updateReview(
        businessId:_business?.id??'',
      reply: reply,
      rev: review,
      gToken: _gToken??''
    ) ;

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = Review.fromJson(d['data']);
        Provider.of<AiProvider>(context,listen: false).clearController();
        for(int i=0;i<_review.length;i++)
          {
            if(_review[i].reviewId==_da.reviewId)
              {
                _review.removeAt(i);
                _review.insert(i,_da);
              }
          }
        Navigator.pop(context);

        notifyListeners();
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


  requestDelete(BuildContext context,Review r) async
  {

    bool? p = await OpenDailovgWithAnimation(context,
        barriarDissmesible: false,
        dailog: WillPopScope(
          onWillPop: ()async{
            return false;
          },
          child: Center(
                child: Card(
          margin: EdgeInsets.all(20),
          child:Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: SC.from_width(10),),
                Text("Delete This Responce",style: AppConstant.labelStylTextField(BuildContext),),

                SizedBox(height: SC.from_width(30),),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Expanded(
                      child: MyactionButton(
                        action: ()async{
                          await _deleteReview(context, r);
                          Navigator.pop(context);
                        },lable: 'Delete',),
                    ),

                    SizedBox(width: SC.from_width(10),),

                    Expanded(

                      child: MyactionButton(
                        inversTheme: true,
                        action: ()async{
                        Navigator.pop(context);
                      },lable: 'Cancle',),
                    ),

                  ],
                ),
              ],
            ),
          ),
                ),
              ),
        ));

  }



  _deleteReview(BuildContext context,Review review) async
  {

    var resp = await _api.deleteReviewResponce(
        businessId:_business?.id??'',
        revId: review.reviewId??'',
        gToken: _gToken??''
    ) ;

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = Review.fromJson(d['data']);
        for(int i=0;i<_review.length;i++)
        {
          if(_review[i].reviewId==_da.reviewId)
          {
            _review.removeAt(i);
            _review.insert(i,_da);
          }
        }
        notifyListeners();
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