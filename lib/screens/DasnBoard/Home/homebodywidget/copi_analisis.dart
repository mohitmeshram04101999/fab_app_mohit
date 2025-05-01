import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/home_responce_model.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/Home_sub_screens/competitor_analysis_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CompetitorAnalysisCard extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MyCard(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //
            Text(
              'Competitor Analysis',
              style:  AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),
            ),

            //
            SizedBox(height: 16.0),
            Consumer<HomeProvider>(

              builder: (context, p, child) {

                if(p.loading)
                  {
                    return Padding(
                        padding: EdgeInsets.all(10),
                      child: Text("Loading",style: AppConstant.labelStyle2(BuildContext),),
                    );
                  }


                return Container(
                  child: Column(
                    children: [

                      Row(

                          children: [
                            Expanded(
                              flex: 2,
                                child: Text("Business name",style: AppConstant.richInfoTextLabel(BuildContext),)),


                            Expanded(child: Center(child: Text("Review",style: AppConstant.richInfoTextLabel(BuildContext),))),
                            Expanded(child: Center(child: Text("Rating",style: AppConstant.richInfoTextLabel(BuildContext),))),
                            Expanded(child: Center(child: Text("Photo",style: AppConstant.richInfoTextLabel(BuildContext),))),

                          ]
                      ),

                      SizedBox(height: SC.from_width(5),),

                      for(CompetitorAnalysis i in p.homeData?.data?.competitorAnalysis??[])
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: SC.from_width(5),),
                              child: Row(
                                children: [
                              
                                  Expanded(
                                    flex: 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(i.businessName??'',maxLines: 1,)),
                                          Icon(Icons.keyboard_arrow_down,size: SC.from_width(18),),
                                          SizedBox(width: SC.from_width(5),)
                                        ],
                                      )),

                              
                                  Expanded(child: Center(child: Text('${i.reviews??0}'))),
                              
                              
                                  //
                                  Expanded(
                                    child: Container(

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons.star,color: AppConstant.primaryColor,size: SC.from_width(13),),
                                          SizedBox(width: SC.from_width(3),),
                                          Text('${i.rating??0}'),
                                        ],
                                      ),
                                    ),
                                  ),
                              
                                  //
                                  Expanded(
                              
                                    child: Center(child: Text('${i.photos??0}')),
                                  ),
                              
                              
                                ],
                              ),
                            ),

                            if(i.businessName!=p.homeData?.data?.competitorAnalysis?.last.businessName)
                              Divider()
                          ],
                        ),






                    ],
                  ),
                );

              },

            ),
            
            SizedBox(height: SC.from_width(30),),
            
            MyactionButton(action: (){
              RouteTo(context, child: (p0, p1) => CompetitorAnalysisDetailScreen(),);
            },lable: 'View ${Provider.of<HomeProvider>(context,listen: false).homeData?.data?.moreCompetitorAnalysis??0} More',)
          ],
        ),
      ),
    );
  }
}