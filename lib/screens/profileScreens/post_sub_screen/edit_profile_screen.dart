import 'package:fab_app/componenet/customField.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/screens/profileScreens/profile_screen_body/profileAvtar.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).editMode();
  }

  @override
  Widget build(BuildContext context) {

    final gap = SizedBox(height: SC.from_width(20),);

    return MyScaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),


      body: Consumer<AuthProvider>(
        builder: (context, p, child) => WillPopScope(
          onWillPop: () async{
            p.clearEdit();
            return true;
          },
          child: ListView(

            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 20),

            children: [
              
              SizedBox(height: SC.from_width(30),),

              Center(
                  child:
              SizedBox(
                height: SC.from_width(100),
                width: SC.from_width(100),
                child: ProfileAvtar(
                  fromeFile:p.changeImage!=null,
                  onEditPressed: (){
                    p.selectProfileImage();
                  },
                    imageUrl:'${p.changeImage??p.user?.user?.userImage}'),
              ),
              ),
              gap,





              CustomField(
                controller: p.nameController,
                hintText: 'Name',
              ),
              gap,

              //
              CustomField(
                controller: p.emailController,
                hintText: 'Email',
                redOnly: true,
              ),
              gap,

              //
              CustomField(
                controller: p.phoneController,
                keyBoardType: TextInputType.number,
                hintText: 'Phone Number',
                redOnly: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
              gap,//

              MyactionButton(action: () async{
                 await p.updateProfile(context);
              },lable: 'Save',)




            ],
          ),
        ),
      ),

    );
  }
}
