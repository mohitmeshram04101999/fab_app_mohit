import 'dart:ui';

import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/google_detaile_report_responce.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


class DetailReportListTile extends StatelessWidget {
  final active;
  final GoogleReport data;

  const DetailReportListTile({
    Key? key,

    this.active=true,
    required this.data,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      elevation: 4,
      margin: EdgeInsets.zero,
      child: SizedBox(

        child: Stack(
          children: [
            ListTile(

              contentPadding: EdgeInsets.symmetric(
                horizontal: SC.from_width(6),
                vertical: SC.from_width(6)
              ),




              leading: Container(
                // color: Colors.red,
                width: SC.from_width(70),
                height: SC.from_width(70),

                //
                child: SleekCircularSlider(

                  appearance: CircularSliderAppearance(

                    customColors: CustomSliderColors(
                      dotColor: Colors.transparent,
                      progressBarColor: Color.fromRGBO(39, 211, 220, 1),
                      trackColor: Colors.grey.shade300
                    ),


                    customWidths: CustomSliderWidths(
                      trackWidth: 3,
                      progressBarWidth: 3,
                      shadowWidth: 0
                    ),

                    infoProperties: InfoProperties(

                      mainLabelStyle:   AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),

                      modifier: (percentage) {
                        return '${data.reviewScore??0}/${data.totalPoint??0}';
                      },

                    ),

                    startAngle: 0,
                    angleRange: 360


                  ),

                  max: data.totalPoint?.toDouble()??100,
                  min: 0,
                  initialValue: data.reviewScore?.toDouble()??0,
                  // Optional callback
                ),
              ),
              //
              title: Text(
                '${data.title??''}',
                style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),),

              //
              subtitle: Text(
                "${data.description??''}",
                maxLines: 2, overflow: TextOverflow.ellipsis,
                style: AppConstant.richInfoTextLabel(BuildContext),
              ),
            ),

            //
            if(!active)
              Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                  child: SizedBox(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}