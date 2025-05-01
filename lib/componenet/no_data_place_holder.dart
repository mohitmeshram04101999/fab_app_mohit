import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';


class NoDataPlaceHolder extends StatelessWidget {
  final String? lable;
  const NoDataPlaceHolder({this.lable,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.none,
        height: SC.from_width(120),
        width: SC.from_width(120),
        decoration: BoxDecoration(



        ),
        child: Stack(
          // clipBehavior:Clip.none,
          children: [
            Positioned(
                left: SC.from_width(-80),
                right:SC.from_width(-80),
                top: SC.from_width(-80),
                bottom:SC.from_width(-100),
                child: Image.asset("assets/icons/no_data.gif")),

            Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child:Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(lable??'',style: AppConstant.richInfoTextLabel(BuildContext),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                ))
          ],
        ));
  }
}
