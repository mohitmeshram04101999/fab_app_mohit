
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/primiuam_perches_message_widget.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/auth%20screesn/login_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

showSnakeBar(BuildContext context,{required String message,Color? color})
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1),
    backgroundColor: color,
      content: Text(message,style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.white),)));
}

serverErrorWidget(BuildContext context,String data)
{

  OpenDailovgWithAnimation(context, dailog: SizedBox(
    height: SC.Screen_height/2,
    child: AlertDialog(
    
      title: Text("Server Error"),
      content: SingleChildScrollView(child: HtmlWidget(data)),
    ),
  ));

}


hendel(List<ConnectivityResult> c)
{

  print('this is change New');

}


premiumPopUp(BuildContext context) async
{
  await OpenDailovgWithAnimation(context,
      animation: dailogAnimation.slidUp,
      dailog: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PremiumPerchesMessageWidget(onReturn: (){Navigator.pop(context);},),
          ],),
      ));
}


tokeExpire(BuildContext context)
{
  DB().clear();
  ReplaceAll(context, child: (p0, p1) => LogInScreen(),);
}