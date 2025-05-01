import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBusinessTile extends StatelessWidget {
  final BusinessModel account;
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

        title: Text('${account.name}'),



        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: SC.from_width(16),
          color: Colors.black
        ),

        //
        subtitle: Consumer<AuthProvider>(
          builder: (context, p, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SC.from_width(8),),
              Text('${p.user?.user?.email??p.googleAccount?.email??''}',maxLines: 1,overflow: TextOverflow.ellipsis,),


            ],),

        ),

        //
        onTap: () {
          Provider.of<CurruntBusinessProvider>(context,listen: false).setBusiness(context,account);
          ReplaceAll(context, child: (p0, p1) => DashBoard());
        },
      ),
    );
  }
}
