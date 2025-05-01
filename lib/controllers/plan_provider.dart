import 'dart:convert';

import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/models/getAllPlanResponceModel.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class PlanProvider with ChangeNotifier
{


  List<Plan> _plans = [];
  bool _loadin = true;
  bool _loadinMore = false;
  int _page = 1;
  BusinessModel? _business;
  String? _gToken;

  List<Plan> get plans => _plans;
  bool get loading => _loadin;
  bool get loadingMore =>_loadinMore;


  getAllPlan(BuildContext context) async
  {

    _page = 1;
    _loadin = true;

    var resp = await AuthApi().getAllPlan();

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = GetAllPlanResponceModel.fromJson(d);
        _plans = _da.data??[];
        if(_plans.isNotEmpty)
          {
            _page++;
          }

        break;

      case 400:
        showSnakeBar(context,color: Colors.red, message: "${jsonDecode(resp.body)['message']}");
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


  getMorePlan(BuildContext context) async
  {

    _loadinMore = true;

    var resp = await AuthApi().getAllPlan();

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _da = GetAllPlanResponceModel.fromJson(d);
        _plans = _da.data??[];
        if(_plans.isNotEmpty)
        {
          _page++;
        }

        break;

      case 400:
        showSnakeBar(context,color: Colors.red, message: "${jsonDecode(resp.body)['message']}");
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

    _loadin = true;
    notifyListeners();

  }





  startPayment(BuildContext context,Plan p)
  {

    _purchasePlan(context, p);

    // var _razorpay = Razorpay();
    //
    //
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (r)=>_handlePaymentSuccess(r,context,p));
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,(r)=> _handlePaymentError(r,context));
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (r)=>_handleExternalWallet(r,context));
    //
    //
    // var options = {
    //   'key': 'rzp_test_rbtiJwMEVvjiw6',
    //   'amount': 100,
    //   'name': 'Payment for ${p.planName??''}',
    //   'description': '${p.planDescription}',
    //   'prefill': {
    //     'contact': '8888888888',
    //     'email': 'test@razorpay.com'
    //   }
    // };
    //
    // _razorpay.open(options);


  }


  _purchasePlan(BuildContext context,Plan plan) async
  {

    var userPro = Provider.of<AuthProvider>(context,listen: false);
    var resp  = await AuthApi().purchasePlan(
        userId:userPro.user?.user?.id??'',
        planId: plan.id
    );

    switch(resp.statusCode)
    {
    case 201:
  var d = jsonDecode(resp.body);
  showSnakeBar(context, message: "Plan Has Purchased",color: Colors.green);
  await userPro.refreshUser(context);
  Navigator.pop(context);
  break;

  case 400:
  showSnakeBar(context,color: Colors.red, message: "${jsonDecode(resp.body)['message']}");
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


  // void _handlePaymentSuccess(PaymentSuccessResponse response,BuildContext context,Plan plan)async{
  //   await purchasePlan(context, plan);
  //
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response,BuildContext context) {
  //   showSnakeBar(context, message: "Payment Failed\n${response.error}");
  //
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response,BuildContext context) {
  //   showSnakeBar(context, message: "Payment From External Wallet");
  // }




}