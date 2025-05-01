import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool blueLabel;

  const CustomButton2({
    Key? key,
    this.label,
    this.blueLabel=false,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Ink(
        height: SC.from_width(39),
        width: double.infinity,
        decoration: AppConstant.customButtonDecoration().copyWith(border: Border.all(
          color: (blueLabel)?AppConstant.primaryColor:Colors.grey
        )),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Minimize the row's width
            children: [
              // icon??Image.asset('assets/hoem/prgressIcon.png',height: SC.from_width(25),width: SC.from_width(25),),
              SizedBox(width: 8.0),
              if (label != null) Text(label!,
              style: AppConstant.buttonTExtStyle(BuildContext).copyWith(color: (blueLabel)?AppConstant.primaryColor:Colors.black),),
            ],
          ),
        ),
      ),
    );
  }
}
