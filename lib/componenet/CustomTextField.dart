import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class CustomTextField extends StatelessWidget {
  final bool showButton;
  final String? lable;
  final TextEditingController? controller;
  final String? hintText;
  final List<TextInputFormatter>? formater;
  final String? Function(String?)? validator;
  final void Function()? oButtonTap;
  final Widget? trailingIcon;
  final bool? extend;
  final bool? readOnly;
  final bool boldHintText;
  final int? maxLine;
  final String? initText;
  final EdgeInsets? contentPed;
  const CustomTextField({this.boldHintText=false,this.readOnly,this.initText,this.contentPed,this.maxLine =1,this.extend,this.trailingIcon,this.oButtonTap,this.showButton=false,this.lable,this.validator,this.formater,this.controller,this.hintText,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(lable!=null)
          Text('$lable',style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),),

        MyCard(
          margin: EdgeInsets.only(top: SC.from_width(6)),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: readOnly??false,
                        initialValue: initText,
                        style: AppConstant.richInfoTextLabel(BuildContext),
                        controller: controller,
                        inputFormatters: formater,
                        maxLines: maxLine,

                        validator: validator,



                        decoration: InputDecoration(
                          contentPadding: contentPed??EdgeInsets.symmetric(horizontal: SC.from_width(10)),
                          hintText: hintText,
                          hintStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(color:(boldHintText)?Colors.black:Colors.grey.shade500),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),

                      ),
                    ),
                    if(trailingIcon!=null)
                      Padding(
                        padding: EdgeInsets.only(right: SC.from_width(10)),
                        child: Theme(
                            data: ThemeData(
                              iconTheme: IconThemeData(
                                color: AppConstant.primaryColor
                              )
                            ),
                            child: trailingIcon!),
                      ),
                  ],
                ),
                if(showButton)
                  Padding(
                    padding:  EdgeInsets.only(
                      top: SC.from_width(24),
                      bottom: SC.from_width(10),
                      left: SC.from_width(13),
                      right: SC.from_width(13)
                    ),
                    child: CustomButton2(
                      onTap: oButtonTap,
                      blueLabel: true,
                      label: 'Generate with AI',
                    ),
                  )
              ],
            ),
        ),


      ],
    );
  }
}
