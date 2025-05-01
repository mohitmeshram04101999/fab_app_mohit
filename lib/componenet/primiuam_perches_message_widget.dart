import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/packageScreens/all_plan_screen.dart';
import 'package:flutter/material.dart';


class PremiumPerchesMessageWidget extends StatelessWidget {
  final void Function()? onReturn;
  const PremiumPerchesMessageWidget({this.onReturn,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,


        child: MyCard(
          elevation: 4,
          margin: EdgeInsets.zero,

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SC.from_width(28)),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                SizedBox(height: SC.from_width(8),),
                Text("See Your all Score",
                  style: AppConstant.labelStyl(BuildContext).copyWith(color: AppConstant.primaryColor),),
                SizedBox(height: SC.from_width(2),),

                //

                Text("With Premium, you can see all\nscore. Upgrade Now",
                  textAlign: TextAlign.center,
                  style: AppConstant.richInfoTextLabel(BuildContext),),
                SizedBox(height: SC.from_width(8),),

                MyactionButton(
                  showLoader: false,
                  height: SC.from_width(35),
                  action: ()async{
                    await RouteTo(context, child: (p0, p1) => AllPlanScreen(),);
                    if(onReturn!=null)
                      {
                        onReturn!();
                      }
                  },lable: 'Try Premium for ₹299',),
                SizedBox(height: SC.from_width(8),),

              ],),
          ),
        ));
  }
}
