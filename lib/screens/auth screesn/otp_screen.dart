import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/auth%20screesn/connect_with_google.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';


class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();

  void _verifyOTP() {

    if (key.currentState!.validate()) {
      // Perform OTP verification logic here
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('OTP Verified Successfully!')),
      // );
      RouteTo(context, child: (p0, p1) => ConnectWithGoogleScreen(),);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, p, child) => MyScaffold(

        //
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SC.from_width(98)),
              // Enter OTP Text
              Text(
                'Enter OTP',
                style: AppConstant.labelStyl(BuildContext),
              ),
              SizedBox(height: SC.from_width(2)),

              // We have sent a 4-digit code to your phone
              Text(
                'We have sent a 4-digit code to your phone',
                style: AppConstant.infoTextLabel(BuildContext),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: SC.from_width(17)),

              // OTP Input Field
              Center(
                child: Form(
                  key: key,
                  child: Pinput(
                    separatorBuilder: (index) => SizedBox(width: SC.from_width(25),),
                    controller: p.otpController,
                    defaultPinTheme: PinTheme(
                        textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: SC.from_width(30)
                        ),
                        height: SC.from_width(70),
                        width: SC.from_width(63),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),

                            border: Border.all(
                                color: Colors.grey.shade300
                            )
                        )
                    ),
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 4) {
                        return 'Please enter a valid 4-digit OTP';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: SC.from_width(64)),

              // Verify OTP Button
              MyactionButton(
                action: ()async{
                  if(key.currentState?.validate()==true)
                    {
                      await p.verifyOtp(context);
                    }
                },
                lable: 'Verify OTP',
              ),
              SizedBox(height: SC.from_width(25)),

              //Info Text
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppConstant.richInfoTextLabel2(BuildContext),
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
              )
            ],
          ),
        ),
      ),

    );
  }
}