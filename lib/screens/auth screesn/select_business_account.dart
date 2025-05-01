
import 'package:fab_app/componenet/SelectBusinessTIile.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/businessControllers.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';





class SelectAccountScreen extends StatefulWidget {




  @override
  State<SelectAccountScreen> createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var auth = Provider.of<AuthProvider>(context,listen: false);

    Provider.of<BusinessProvider>(context,listen: false).getAllBusiness(context, token: auth.googleToken);


  }

  double val = 0;


  @override
  Widget build(BuildContext context) {


    return MyScaffold(



      floatingActionButton:  MyactionButton(action: () async{
        await Provider.of<AuthProvider>(context,listen: false).logOut(context);
      },lable: "Log Out",),

      //
      appBar: AppBar(
        leading: SizedBox(width: SC.from_width(5),),
        leadingWidth: 12,
        title: Text('Account',
        style: TextStyle(fontWeight: FontWeight.w600,fontSize: SC.from_width(20)),),
        titleSpacing: 0,
      ),

      //
      //
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //
            // WaveSlider(
            //   maxValue: 100,
            // minValue: 0,
            // onDrag: (d){
            //   setState(() {
            //     val = d;
            //   });
            // },
            // ),

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
              child: Consumer<BusinessProvider>(
                builder: (context, p, child) {

                  if(p.loading)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                  if(p.allBusiness.isEmpty)
                    {
                      return Center(child:  MyactionButton(action: () async{
                        await Provider.of<AuthProvider>(context,listen: false).logOut(context);
                      },lable: "",));
                    }

                  return ListView.builder(
                    itemCount: p.allBusiness.length,
                    itemBuilder: (context, index) {
                      final account = p.allBusiness[index];
                      return SelectBusinessTile(account: account);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}