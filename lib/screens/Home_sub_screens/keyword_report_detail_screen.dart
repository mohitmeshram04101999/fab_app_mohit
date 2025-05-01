import 'dart:ui';

import 'package:fab_app/componenet/keyWordListTile.dart';
import 'package:fab_app/componenet/primiuam_perches_message_widget.dart';
import 'package:fab_app/componenet/scaffold_for_pimium.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/controllers/homeScreenDetailProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class KeywordReportDetailScreen extends StatefulWidget {
  const KeywordReportDetailScreen({super.key});

  @override
  State<KeywordReportDetailScreen> createState() => _KeywordReportDetailScreenState();
}

class _KeywordReportDetailScreenState extends State<KeywordReportDetailScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<KeyWordDetailProvider>(context,listen: false).getMoreKeyWord(context);
  }


  @override
  Widget build(BuildContext context) {
    return MyScaffold(


      bottomSheet: Consumer<KeyWordDetailProvider>(builder:(context, p, child){


        if(p.user?.subscription?.isPlanExpired==false && p.user?.subscription?.planDetails?.keywordReport==true)
          {
            return SizedBox();
          }
        return  PremiumPerchesMessageWidget(
          onReturn: (){p.upDate();},
        );

      },),

      appBar: AppBar(
        title: Text("Keyword Report"),
      ),



      //

      body:  Consumer<KeyWordDetailProvider>(
        builder: (context,p, child) {

          //
          if(p.loadingKeyWords)
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          if(p.moreKeyWords.isEmpty)
            {
              return Center(
                child: Text('${Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id}'),
              );
            }

          return ListView(

            //
            physics:(p.user?.subscription?.isPlanExpired==false && p.user?.subscription?.planDetails?.keywordReport==true)?
            null:
            NeverScrollableScrollPhysics(),

            //
            padding: EdgeInsets.symmetric(horizontal: SC.from_width(17),vertical: 20),
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: SC.from_width(5),vertical: SC.from_width(5)),
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text("dataCampaign Name",style: AppConstant.richInfoTextLabel(BuildContext),)),
                    Expanded(child: Center(child: Text("Search",style: AppConstant.richInfoTextLabel(BuildContext),)))
                  ],
                ),
              ),
              SizedBox(height: SC.from_width(5),),



              for(int i =0;i<p.moreKeyWords.length;i++)
                KeyWordListTile(
                  blur: i>2&&(p.user?.subscription?.isPlanExpired==true||p.user?.subscription?.planDetails?.keywordReport==false),
                    keyword: p.moreKeyWords[i],
                )


            ],
          );
        },

      ),


    );
  }
}
