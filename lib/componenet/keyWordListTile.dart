import 'dart:ui';

import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';

import 'package:fab_app/models/more_key_words_model.dart';
import 'package:flutter/material.dart';

class KeyWordListTile extends StatelessWidget {
  final MoreKeyword keyword;
  final bool blur;
  const KeyWordListTile({this.blur= false,required this.keyword,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SC.from_width(30),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(

      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    maxLines: 1,
                    "${keyword.name??''}",
                    overflow: TextOverflow.ellipsis,
                    style: AppConstant.richInfoTextLabel(BuildContext),)),
              Expanded(child: Center(child: Text("${keyword.count??0}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: AppConstant.primaryColor),)))
            ],
          ),

          if(blur)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                child: Container(
                  height: SC.from_width(30),

                ),
              ),
            ),


          SizedBox(height: double.infinity,width: double.infinity,)

        ],
      ),
    );
  }
}
