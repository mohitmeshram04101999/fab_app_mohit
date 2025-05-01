import 'package:fab_app/componenet/HelpButtom.dart';
import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/profile_tile.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';


class MarkitingScreen extends StatelessWidget {
  MarkitingScreen({super.key});

  var data = [

    {
      'title':'Build brand with Whatsapp',
      'icon':'assets/icons/whatsApp.png',
    },

    {
      'title':'Influencer Marketing',
      'icon':'assets/icons/insta.png',
    },

    {
      'title':'Learn marketing with FAB',
      'icon':'assets/icons/mark.png',
    },


  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(


      
      floatingActionButton:  HelpButtom(),

      body: Column(
        children: [

          SizedBox(height: SC.from_width(10),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ProfileTile(),
          ),
          
          SizedBox(
            height: SC.from_width(33),
          ),



          //
          MyCard(
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SC.from_width(17),),
                  Text("Marketing Channels",style: AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),),
                  SizedBox(height: SC.from_width(18),),



                  for(var i in data)
                    Container(
                        margin: EdgeInsets.only(
                            bottom: 10
                        ),

                        decoration: BoxDecoration(
                            color: Colors.white,

                          boxShadow: [

                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 2),
                              color: Colors.grey.shade200
                            )
                          ]
                        ),
                        child: ListTile(
                          
                          //
                          leading: Image.asset("${i['icon']}"),

                          title: Text("${i['title']}"),
                        )
                    ),
                  
                  SizedBox(height: SC.from_width(27),)
                  


                ],
              ),
            ),
          )

        ],
      ),

    );
  }
}
