import 'dart:ui';

import 'package:fab_app/componenet/primiuam_perches_message_widget.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';



class ScaffoldForPimium extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;
  const ScaffoldForPimium({this.body,this.appBar,super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      appBar: appBar,

      body: Stack(
        children: [
          if(body!=null)
            body!,

          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              top: SC.Screen_height/3,

              child:Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 4,sigmaX: 4),
                  child: SizedBox(),
                ),
              ))
        ],
      ),


      bottomSheet: PremiumPerchesMessageWidget(),


    );
  }
}
