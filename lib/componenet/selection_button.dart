import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';



class SelectionButton extends StatelessWidget {

  final bool active;
  final String lable;
  final void Function()? onTap;
  final bool type2;
  const SelectionButton({this.type2 =false,this.onTap,this.active=false,required this.lable,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Container(


        padding: EdgeInsets.symmetric(
          horizontal: SC.from_width(18),
          vertical: SC.from_width(6)
        ),

        decoration: BoxDecoration(

            color: active?AppConstant.primaryColor:null,
          borderRadius: BorderRadius.circular(50),


          border: Border.all(color: active?AppConstant.primaryColor: Colors.grey)

        ),


        child: GestureDetector(
          onTap: onTap,
            child: Text(lable,style:(type2==false)? AppConstant.labelStylTextField(BuildContext).copyWith(color: active?Colors.white:null):
              AppConstant.richInfoTextLabel(BuildContext).copyWith(color: active?Colors.white:Colors.grey.shade500),)),

      ),
    );
  }
}
