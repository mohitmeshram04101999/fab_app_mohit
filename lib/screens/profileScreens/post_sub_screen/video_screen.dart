import 'dart:io';

import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/mediaProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';



class VideoScreen extends StatefulWidget {
  final bool clean;
  const VideoScreen({this.clean=false,super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {


  VideoPlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVid();

  }

  initVid() async
  {

  }


  @override
  Widget build(BuildContext context) {
    
    return  Consumer<MediaProvider>(builder: (context, p, child) => WillPopScope(

      onWillPop: ()async{
        p.clearMedia();
        if(widget.clean)
          {
            p.setFileTYpe(null);
          }
        return true;
      },

      child: MyScaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        appBar: AppBar(
          title: Text("Add Video"),
        ),


        body: Column(
          children: [
            Expanded(child: MyCard(
              margin: EdgeInsets.symmetric(
                vertical: 20,horizontal:12
              ),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Thumbnail For Media",style: AppConstant.font_500_14(BuildContext),),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async{

                        await  p.selectMediaVideo(context);
                        controller?.dispose();
                        if(p.selectedMedia!=null)
                        {
                          controller = VideoPlayerController.file(File(p.selectedMedia??''),
                          );
                          await controller!.initialize();
                        p.upDate();
                      }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child:(controller?.value.isInitialized==true)?AspectRatio(
                            aspectRatio: controller?.value.aspectRatio??1,
                            child: VideoPlayer(controller!)):Icon(Icons.video_call),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Thumbnail For Media",style: AppConstant.font_500_14(BuildContext),),
                    ),
                  ),
                  Expanded(

                    child: InkWell(
                      onTap: (){
                        p.selectThumbnailImage(context);
                        
                      },
                      child: SizedBox(
                          child:(p.thumbnail!=null)?
                          Image.file(File(p.thumbnail??''),fit: BoxFit.cover,width: double.infinity,):
                          Center(child: Icon(Icons.image))
                      ),
                    ),
                  )
              
              
                ],
                
              ),
            )),



            MyactionButton(
              margin: EdgeInsets.symmetric(horizontal: 12,vertical: SC.from_width(10)),
              action: () async {
                await p.addMedia(context);
              },lable: 'Save',)



          ],
        ),



      ),
    ),);
  }
}
