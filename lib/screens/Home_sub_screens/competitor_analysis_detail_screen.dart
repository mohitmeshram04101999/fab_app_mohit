import 'dart:ui';

import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/primiuam_perches_message_widget.dart';
import 'package:fab_app/componenet/scaffold_for_pimium.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/compitetor_provider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CompetitorAnalysisDetailScreen extends StatefulWidget {
  CompetitorAnalysisDetailScreen({super.key});

  @override
  State<CompetitorAnalysisDetailScreen> createState() => _CompetitorAnalysisDetailScreenState();
}

class _CompetitorAnalysisDetailScreenState extends State<CompetitorAnalysisDetailScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CompetitorDetailProvider>(context,listen: false).getData(context);
  }


  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      bottomSheet:Consumer<CompetitorDetailProvider>(builder: (context, p, child) {
        if(p.subscription?.isPlanExpired==false&&p.subscription?.planDetails?.competitorAnalysis==true)
          {
            return SizedBox();
          }
        return PremiumPerchesMessageWidget(
          onReturn: (){p.upDate();},
        );
      },) ,

      appBar: AppBar(
        title: Text("Competitor Analysis"),
      ),

      body: Consumer<CompetitorDetailProvider>(
        builder: (context, p, child) {

          if(p.loading)
            {
              return Center(
                child:CircularProgressIndicator(),
              );
            }

          if(p.competitor.isEmpty)
            {
              return Center(
                child: NoDataPlaceHolder(),
              );
            }

          return ListView(
            physics: (p.subscription?.isPlanExpired==false&&p.subscription?.planDetails?.competitorAnalysis==true)?null:NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: SC.from_width(12),vertical: 20),
            children: [

              Container(
                padding: EdgeInsets.symmetric(vertical: SC.from_width(5)),
                color: Colors.grey.shade100,
                child: Row(children: [

                  Expanded(flex: 2,child: Text("Business Name",style: AppConstant.richInfoTextLabel(BuildContext),)),

                  //
                  Expanded(child: Center(child: Text("Reviews",style: AppConstant.richInfoTextLabel(BuildContext)))),

                  //
                  Expanded(child: Center(child: Text("Ratings",style: AppConstant.richInfoTextLabel(BuildContext)))),

                  //
                  Expanded(child: Center(child: Text("Photo",style: AppConstant.richInfoTextLabel(BuildContext)))),

                ],),
              ),
              SizedBox(height: SC.from_width(10),),

              for(int i=0; i<p.competitor.length;i++)
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(),
                  height: SC.from_width(35),

                  child: Column(
                    children: [
                      Row(children: [

                        //Business Name
                        Expanded(flex: 2,child: Row(
                          children: [
                            Expanded(child: Text(
                              "${p.competitor[i].businessName??''}",
                              maxLines: 1,
                              style: AppConstant.richInfoTextLabel(BuildContext),)),

                            Icon(Icons.keyboard_arrow_down_rounded,color: AppConstant.primaryColor,),

                            SizedBox(width: SC.from_width(20),)
                          ],
                        )),

                        //
                        Expanded(child: Center(child: Text("${p.competitor[i].reviews??0}",style: AppConstant.richInfoTextLabel(BuildContext)))),

                        //
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star_border_outlined,color: AppConstant.primaryColor,size: SC.from_width(18),),
                            Text("${p.competitor[i].rating??0}",style: AppConstant.richInfoTextLabel(BuildContext)),
                          ],
                        )),

                        //
                        Expanded(child: Center(child: Text("${p.competitor[i].photos??0}",style: AppConstant.richInfoTextLabel(BuildContext)))),

                      ],),

                      //
                      if(i>2&&(p.subscription?.isPlanExpired==true||p.subscription?.planDetails?.competitorAnalysis!=true))
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 4,sigmaX: 4),
                        child: SizedBox(),
                      )
                    ],
                  ),
                )

            ],
          );
        },

      ),

    );
  }
}
