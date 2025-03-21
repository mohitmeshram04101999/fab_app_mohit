import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/material.dart';




class GoogleDataReportWidget extends StatelessWidget {
  const GoogleDataReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adds shadow to the card
      margin: EdgeInsets.symmetric(horizontal: 10), // Adds margin around the card
      child: Column(
        children: <Widget>[
          ListTile(
            
            title: Text('Google Audit Score', style: TextStyle(fontWeight: FontWeight.bold)),
            titleTextStyle: AppConstant.labelStylTextField(BuildContext),
            subtitleTextStyle: AppConstant.richInfoTextLabel(BuildContext),
            subtitle: Text('Based on your data from google business'),
          ),
          SizedBox(height: SC.from_width(16),),

          //
          Image.asset(
            'assets/hoem/googlerepoft banner.png',

            width: double.infinity,
            height: 150.0,
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyactionButton(action: (){},lable: 'Check Datailed Report',),
          ),
          SizedBox(height: SC.from_width(11),)
          
        ],
      ),
    );
  }
}
