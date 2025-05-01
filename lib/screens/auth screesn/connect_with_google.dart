import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';

import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/dash_board.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';





class ConnectWithGoogleScreen extends StatefulWidget {

  @override
  State<ConnectWithGoogleScreen> createState() => _ConnectWithGoogleScreenState();
}

class _ConnectWithGoogleScreenState extends State<ConnectWithGoogleScreen> {
   var v;

  void _connectWithGoogle(BuildContext context) async{
    await Provider.of<AuthProvider>(context,listen: false).connectWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(





      body: SingleChildScrollView(
        child: Column(
          children: [




            // Text
            SizedBox(height: SC.from_width(75)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select an Email or connect with Google to continue',
                style: AppConstant.infoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),
              ),),

            Container(
              margin: EdgeInsets.symmetric(horizontal: SC.from_width(29)),
              height: SC.from_width(298),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/auth_image/connectWithGoogleBanner.png'), // Add your banner image
                ),
              ),
            ),




            // Connect with Google Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyactionButton(
                action: ()=>_connectWithGoogle(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      child: Image.asset(
                        'assets/auth_image/googleLogo.png', // Add Google logo asset
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Connect with Google',
                      style:AppConstant.buttonTExtStyle(BuildContext),
                    ),
                  ],
                ),
              ),
            ),


              Consumer<AuthProvider>(
                builder: (context, p, child) => Column(
                  children: [
                    SizedBox(height: SC.from_width(30),),
                    MyactionButton(action: ()async{
                      await GoogleSignIn().signOut();
                    },lable: 'signOut',),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(String g in p.logs)
                            Card(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SelectableText(g),
                            )),
                        ],
                      )
                    ),
                  ],
                ),

              ),
          ],
        ),
      ),
    );
  }
}