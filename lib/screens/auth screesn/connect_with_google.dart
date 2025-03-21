import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/auth%20screesn/select_business_account.dart';
import 'package:flutter/material.dart';




class ConnectWithGoogleScreen extends StatelessWidget {
  void _connectWithGoogle(BuildContext context) {
    // Add Google sign-in logic here
    print('Connect with Google clicked');
    RouteTo(context, child: (p0, p1) => SelectAccountScreen(),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
          ],
        ),
      ),
    );
  }
}