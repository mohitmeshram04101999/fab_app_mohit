import 'dart:typed_data';

import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/controllers/mediaProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/video_screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';




class MediaWidget extends StatefulWidget {
  final Media media;
  const MediaWidget({required this.media,super.key});

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {


 late VideoPlayerController _controller;



 Uint8List? imageByt;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.media.mediaFormat=='VIDEO')
      {
        // initController();
      }
  }


  var done  =  false;


  initController()async
  {

  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    //PHOTO,VIDEO
    return AspectRatio(aspectRatio: 1,
    child: Stack(
      children: [

        //
        (widget.media.mediaFormat=='PHOTO')?
        Image.network('${widget.media.media}',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.network('${MyUrl.bucketUrl}${widget.media.media}',
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(30),),
          ),
        ): Image.network('${widget.media.thumbnail}',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.network('${MyUrl.bucketUrl}${widget.media.thumbnail}',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(30),),
          ),
        ),

        if(widget.media.mediaFormat=="VIDEO")
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.play_arrow),
            ),
          )
      ],
    ),) ;
  }
}
