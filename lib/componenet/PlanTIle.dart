import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/plan_provider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/getAllPlanResponceModel.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanTile extends StatelessWidget {
  final Plan plan;
  const PlanTile({required this.plan,super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(

      builder: (context, p, child) => Container(
        padding:  EdgeInsets.all(8),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
          top: 10,
          bottom: SC.from_width(10),
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 3,
              offset: Offset(2,2)
            )
          ]
        ),

        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SC.from_width(10),),
            //
            Text("${plan.planName}",
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppConstant.labelStyle2(BuildContext).copyWith(fontSize: SC.from_width(20)),),
            SizedBox(height: SC.from_width(4),),

            //
            Text("${plan.planDescription}",
              textAlign: TextAlign.center,
              style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
            SizedBox(height: SC.from_width(4),),

            //
            Text("${plan.amount??0}",style: AppConstant.labelStyle2(BuildContext).copyWith(color: AppConstant.primaryColor,fontSize: SC.from_width(20)),),
            SizedBox(height: SC.from_width(4),),

            //
            Text("For ${plan.validity??0} Days",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
            SizedBox(height: SC.from_width(4),),
            Divider(color: Colors.grey.shade500,),

            Expanded(child:SingleChildScrollView(
              child: Column(
                children: [
                  selection("Product Management",plan.productManagement??false),
                  selection("Service Management",plan.serviceManagement??false),
                  selection("Detailed Report",plan.detailedReport??false),
                  selection("Keyword Report",plan.keywordReport??false),
                  selection("Competitor Analysis",plan.keywordReport??false),
                  selection("Add Event", plan.addEvent??false),
                  selection("Reply With Ai", plan.addEvent??false),

                ],
              ),
            )),
            MyactionButton(
              margin: EdgeInsets.all(8),
              inversTheme: !(p.user?.subscription?.planDetails?.planName==plan.planName),
              action: ()async{
                if(p.user?.subscription?.planDetails?.planName==plan.planName)
                {
                }
                else
                {
                  await Provider.of<PlanProvider>(context,listen: false).startPayment(context, plan);
                }
              },lable: (p.user?.subscription?.planDetails?.planName==plan.planName)?'Active Plan':'Purchase Plan',),


          ],
        ),
      ),
    );



  }


  Widget selection(String title,bool selected)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      child: Row(

        children: [
          IconTheme(data: IconThemeData(
            color: (selected)? Colors.green:Colors.red,
          ), child:  (selected)?Icon(Icons.check):Icon(Icons.close), ),
          SizedBox(width: SC.from_width(5),),
          Expanded(child: Text(title,style: AppConstant.font_500_14(BuildContext),)),

        ],
      ),
    );
  }
}
