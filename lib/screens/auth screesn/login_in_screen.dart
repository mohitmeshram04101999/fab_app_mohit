import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/auth%20screesn/otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  bool autovalid = false;

  void _getOTP() {
    autovalid  = true;
    setState(() {

    });
    if (_formKey.currentState!.validate()) {
      // Perform OTP generation logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP Sent to ${_mobileController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: SC.from_width(70),),

            // Banner
            Container(
              height: SC.from_width(252),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/auth_image/logInBanner.jpeg'), // Add your banner image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: SC.from_width(20)),

            // Welcome Text
            Text(
              'Welcome to FAB',
              style: TextStyle(
                color: AppConstant.primaryColor,
                fontSize: SC.from_width(30),
                fontWeight:FontWeight.w700,
              ),
            ),
            SizedBox(height: SC.from_width(12)),


            Container(height: 5,width: SC.from_width(134),decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5)
            ),),
            SizedBox(height: SC.from_width(41)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Enter Mobile Number",
                style: AppConstant.labelStylTextField(BuildContext),),
              ),
            ),
            SizedBox(height: SC.from_width(8)),


            // Mobile Number Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  child: TextFormField(

                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    style:AppConstant.richInfoTextLabel(BuildContext) ,
                    controller: _mobileController,git
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      hintStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 8)

                    ),
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (value.length != 10) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: SC.from_width(29)),

            // Get OTP Button
             MyactionButton(
               action: ()async{

               await Future.delayed(Duration(seconds: 1));
                if(_formKey.currentState?.validate()??false)
                  {
                    RouteTo(context, child: (p0, p1) => OTPScreen(),);
                  }
             },lable: 'Get OTP',),


            SizedBox(height: SC.from_width(20)),

            // Footer Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppConstant.richInfoTextLabel(BuildContext),
                  children: [
                    TextSpan(text: 'By logging in or creating an account, you agree to\nFAB Marketing App\n'),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: AppConstant.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Terms of Service page
                          print('Terms of Service clicked');
                        },
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: AppConstant.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Privacy Policy page
                          print('Privacy Policy clicked');
                        },
                    ),
                    TextSpan(text: '.'),
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