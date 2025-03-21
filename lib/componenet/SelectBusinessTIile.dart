import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';

class SelectBusinessTile extends StatelessWidget {
  final Map account;
  const SelectBusinessTile({required this.account, super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(

      elevation: 2,
      margin: EdgeInsets.only(bottom: 10),

      child: ListTile(
        //
        contentPadding: EdgeInsets.symmetric(vertical: SC.from_width(8),horizontal: SC.from_width(14)),


        leading: SizedBox(
          height: SC.from_width(32),
          width: SC.from_width(32),
          child: Stack(
            children: [
              Image.asset("assets/auth_image/busineSelectIcon.png"),
              Center(child: Icon(Icons.check,color: Colors.white,))
            ],
          ),
        ),

        title: Text(account['title']!),



        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: SC.from_width(16),
          color: Colors.black
        ),

        //
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: SC.from_width(8),),
          Text(account['subtitle']!),


        ],),

        //
        onTap: () {
          // Handle account selection
          print('Selected: ${account['title']}');
        },
      ),
    );
  }
}
