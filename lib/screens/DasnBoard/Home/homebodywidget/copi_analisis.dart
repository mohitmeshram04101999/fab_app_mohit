import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CompetitorAnalysisCard extends StatelessWidget {

  final data = [
    //
    {
      'Business Name':'ABC',
      'Reviews':'163',
      'Ratings':'5',
      'Photo':'12',
    },

    //
    {
      'Business Name':'XYZ',
      'Reviews':'141',
      'Ratings':'4.5',
      'Photo':'12',
    },

    //
    {
      'Business Name':'New tech',
      'Reviews':'138',
      'Ratings':'4.5',
      'Photo':'10',
    },


  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13,vertical: 15),
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
            Table(

              children: [
                
                TableRow(
                  
                    children: [
                      for(var d in data[0].keys)
                        Text(d,style: AppConstant.richInfoTextLabel(BuildContext),)
                    ]
                  ),
                
                for(var d in data)
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey)
                      )
                    ),
                    children: [
                      
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${d['Business Name']}'),
                            Icon(Icons.keyboard_arrow_down,size: SC.from_width(18),)
                          ],
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${d['Reviews']}'),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.star,color: AppConstant.primaryColor,size: SC.from_width(13),),
                            Text('${d['Ratings']}'),
                          ],
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${d['Photo']}'),
                      ),

                      
                      
                    ]
                  )
              ],
            ),
            
            SizedBox(height: SC.from_width(30),),
            
            MyactionButton(action: (){},lable: 'View 8+ More',)
          ],
        ),
      ),
    );
  }
}