
import 'package:fab_app/componenet/SelectBusinessTIile.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/dash_board.dart';
import 'package:flutter/material.dart';





class SelectAccountScreen extends StatelessWidget {
  // Dummy list of business accounts
  final List<Map<String, String>> businessAccounts = [
    {
      'title': 'ABC Online',
      'subtitle': 'business1@example.com',
    },
    {
      'title': 'XYZ onLine',
      'subtitle': 'business2@example.com',
    },
    {
      'title': 'Business Account 3',
      'subtitle': 'business3@example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          //
          MyactionButton(action: (){},
          lable: 'Logout',
            trailingIcon: Icon(Icons.logout),


          ),

          SizedBox(height: SC.from_width(16),),

          //
          MyactionButton(action: (){
            RouteTo(context, child:(p0, p1) =>  DashBoard());
          },
          lable: 'Facebook',
            trailingIcon: Icon(Icons.arrow_forward),
          ),
      ],),

      //
      appBar: AppBar(
        title: Text('Account',
        style: TextStyle(fontWeight: FontWeight.w600,fontSize: SC.from_width(20)),),
        titleSpacing: 0,
        leadingWidth: SC.from_width(50),
      ),
      
      //
      //
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //
            // Heading
            Text(
              'Select your Business Account',
              style: AppConstant.infoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),

            //
            // List of Business Accounts
            Expanded(
              child: ListView.builder(
                itemCount: businessAccounts.length,
                itemBuilder: (context, index) {
                  final account = businessAccounts[index];
                  return SelectBusinessTile(account: account);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}