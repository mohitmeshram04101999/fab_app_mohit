
import 'dart:convert';

import 'package:fab_app/api_service/aiApi.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/models/get_all_review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AiProvider with ChangeNotifier
{
  final TextEditingController _replyController = TextEditingController();
  String? _reply;

  TextEditingController get controller => _replyController;
  String? get reply => _reply;

  clearController()
  {
    print("Controller is celar");
    _replyController.clear();
    _reply = null;
}


setValue(String s)
{
  _replyController.text=s;
  // _reply = s;

}

  getAiReplySolution(BuildContext context,Review review) async
  {
    var auth  = Provider.of<AuthProvider>(context,listen: false);

    print("Checking Subscription ${auth.user?.subscription?.isPlanExpired==true||auth.user?.subscription?.planDetails?.replyWithAi==false}");
    print("Checking Subscription\n ${auth.user?.subscription?.isPlanExpired==true}\n${auth.user?.subscription?.planDetails?.replyWithAi}");
    if(auth.user?.subscription?.isPlanExpired==true||auth.user?.subscription?.planDetails?.replyWithAi==false)
      {
        premiumPopUp(context);
        return ;
      }

    _reply = null;
    notifyListeners();


    var resp = await AiApi().getAiReply(
        prompt: review.comment??'',
    userName:review.reviewerName??''
    );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        setValue( d['response']);
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