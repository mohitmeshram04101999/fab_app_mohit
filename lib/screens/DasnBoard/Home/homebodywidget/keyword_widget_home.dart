import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/material.dart';

class KeywordWidgetHome extends StatelessWidget {
  KeywordWidgetHome({super.key});


  final data = 
    {
      'It Companies in bhopal':120,
      'Bhopal it comanies':89,
      'It Company in bhopal':55
    }
  ;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Keywords",style: AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),),
            SizedBox(height: SC.from_width(14),),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Campaign Name',style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontSize: SC.from_width(14)),),

                Text('Search',style: AppConstant.richInfoTextLabel(BuildContext),)
              ],
            ),
            SizedBox(height: SC.from_width(16),),

            //
            for(var i in data.keys)
              Padding(
                padding: EdgeInsets.only(bottom: SC.from_width(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(i,style: AppConstant.richInfoTextLabel(BuildContext),),

                    Text('${data[i]}',style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: AppConstant.primaryColor),)
                  ],
                ),
              ),

            SizedBox(height: SC.from_width(16),),
            MyactionButton(action: (){},lable: 'View More',)


          ],
        ),
      ),
    );
  }
}
