import 'dart:io';

import 'package:fab_app/api_service/customateDateTIme.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/componenet/CustomTextField.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/postPorovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/SelectMedia%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddEventScreen extends StatelessWidget {
  final bool editMode;
  final Post? post;
  
  const AddEventScreen({this.editMode=false,this.post,super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async
      {
        Provider.of<PostProvider>(context,listen: false).clearFields();
        return true;
      },

      child: MyScaffold(

        appBar: AppBar(

          title: Text("Add Event"),
        ),


        body: Consumer<PostProvider>(builder: (context, p, child) =>
            ListView(
          padding: EdgeInsets.symmetric(horizontal: SC.from_width(12),vertical: SC.from_width(20)),
          children: [

            CustomTextField(
              controller: p.titleController,
              lable: 'Event Title',
              hintText: 'Enter Event Title',
            ),
            SizedBox(height: SC.from_width(20),),


            CustomTextField(
              controller: p.descriptionController,
              showButton: true,
              lable: 'Summary',
              hintText: 'Enter Summary',
            ),
            SizedBox(height: SC.from_width(20),),



            CustomTextField(
              lable: 'Start Date',
              hintText: MyFormate().formateDateTIme(p.startDate)??'Select Date',
              readOnly: true,
              boldHintText: p.startDate!=null,
              trailingIcon: InkWell(
                  onTap: (){
                    p.selectStartDate(context);
                  },
                  child: Icon(Icons.date_range_outlined)),
            ),
            SizedBox(height: SC.from_width(20),),


            //
            CustomTextField(
              lable: 'End Date',
              readOnly: true,
              boldHintText: p.endDate!=null,
              hintText: MyFormate().formateDateTIme(p.endDate)??'Select Date',
              trailingIcon: InkWell(
                  onTap: (){
                    p.selectEndDate(context);
                  },
                  child: Icon(Icons.date_range_outlined)),
            ),
            SizedBox(height: SC.from_width(20),),

            Text("Attachments",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),),
            
            if(p.selectedImage!=null)
              Column(
                children: [
                  SizedBox(height: SC.from_width(5),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(p.selectedImage??''))),
                ],
              ),
            
            if(editMode&&p.selectedImage==null&&post!=null)
              Column(
                children: [
                  SizedBox(height: SC.from_width(5),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(post?.post??'',
                      errorBuilder: (context, error, stackTrace) => Image.network('${MyUrl.bucketUrl}${post?.post}',
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(30),),
                      ),
                    ),
                  ),
                ],
              ),
            
            
            
            SizedBox(height: SC.from_width(103),),

            MyactionButton(
              borderRadius: BorderRadius.circular(8),
              inversTheme: true,
              action: (){
                // RouteTo(context, child: (p0, p1) => SelectMediaScreen(),);
                p.selectImage(context);
              },
              lable: 'Add Media',
              trailingIcon: Icon(Icons.image),
            ),
            SizedBox(height: SC.from_width(12),),

            MyactionButton(
              borderRadius: BorderRadius.circular(8),
              action: () async {
                if(editMode)
                  {
                    await p.updatePost(context,post!);
                  }
                else
                  {
                    await p.createPost(context);
                  }
              },
              lable: 'Save',

            )







          ],
        ),),


      ),
    );
  }
}
