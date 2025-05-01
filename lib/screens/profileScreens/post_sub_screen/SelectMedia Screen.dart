import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/media_widget.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/mediaProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/video_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SelectMediaScreen extends StatefulWidget {
  const SelectMediaScreen({super.key});

  @override
  State<SelectMediaScreen> createState() => _SelectMediaScreenState();
}

class _SelectMediaScreenState extends State<SelectMediaScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MediaProvider>(context,listen: false).getAllPost(context);
  }

  double val = 35;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      appBar: AppBar(
        title: Text("Media"),
      ),


      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("Select Media",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),),
        ),
        SizedBox(height: SC.from_width(6),),

          //
          MyCard(
    margin: const EdgeInsets.symmetric(horizontal: 12),

        child: Consumer<MediaProvider>(
          builder: (context, p, child) => DropdownButtonFormField(
            value: p.fileType,

              decoration: InputDecoration(
                hintText: 'Select Media',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),

              items: [

                DropdownMenuItem(
                    value: 'PHOTO',
                    child: Text("Image")),
                DropdownMenuItem(
                    value: 'VIDEO',
                    child: Text("Video")),

              ], onChanged: (d)
          {
            p.setFileTYpe(d);

          }),
        ),),


          if(kDebugMode)
    Consumer<MediaProvider>(
    builder: (context, p, child) =>WaveSlider(
      minValue: 0,
      maxValue: 100,

      value: val,
      onDrag: (d){
        val = d;
        p.upDate();
      },
    )),

          Consumer<MediaProvider>(
            builder: (context, p, child) {
              if(p.loading)
                {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),);
                }

              if(p.media.isEmpty)
                {
                  return Center(child:NoDataPlaceHolder(),);
                }

              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical:20,horizontal: 12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: SC.from_width(10),
                mainAxisSpacing: SC.from_width(10)),
                itemCount: p.media.length,
                itemBuilder: (context, i){
                return MyCard(
                  margin: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(8),

                    child: MediaWidget(media: p.media[i]));
              },);

            },
          ),


          //
          MyactionButton(
            inversTheme: true,
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            borderRadius: BorderRadius.circular(8),
            action: (){

             var  p =  Provider.of<MediaProvider>(context,listen: false);
             if(p.fileType=='VIDEO')
               {
                 RouteTo(context, child: (p0, p1) => VideoScreen(),);
               }
             else
               {
                 p.addImage(context);
               }
            },lable: 'Add Media',trailingIcon:  Icon(Icons.image),),
          SizedBox(height: SC.from_width(12),),

          //
          MyactionButton(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
            borderRadius: BorderRadius.circular(8),
            action: (){},lable: 'Save'),

      ],),

    );
  }
}
