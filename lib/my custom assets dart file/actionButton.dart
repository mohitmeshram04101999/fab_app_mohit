import 'dart:developer';

import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class MyactionButton extends StatefulWidget {
  Color? color;
  bool? handelError;
  Duration? duretion;
  Widget? child;
  Widget? trailingIcon;
  double? height ;
  String? customErrorMessage;
  String? lable;
  Curve? curve;
  double? width;
  Function(dynamic)? onActionComplit;
  Function action;
  Widget? activeChild;
  BoxDecoration? decoration;
  BoxDecoration? activeDecoration;
  MyactionButton(
      {this.handelError,
        this.lable,
        this.color,
        this.customErrorMessage,
        this.curve,
        this.height,
        this.trailingIcon,
        this.width,
        this.onActionComplit,
        required this.action,
        this.child,
        this.activeChild,
        this.decoration,
        this.activeDecoration,
        this.duretion,
        super.key});

  @override
  State<MyactionButton> createState() => _MyactionButtonState();
}

class _MyactionButtonState extends State<MyactionButton> {
  @override
  void didUpdateWidget(covariant MyactionButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  bool loding = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (loding == false) {
          loding = true;
          setState(() {});


          if(kDebugMode)
            {
              dynamic returnData = await widget.action();
              log(widget.onActionComplit.toString());
              if (widget.onActionComplit != null) {
                widget.onActionComplit!(returnData);
              }
            }
          else
            {
              try {
                dynamic returnData = await widget.action();
                log(widget.onActionComplit.toString());
                if (widget.onActionComplit != null) {
                  widget.onActionComplit!(returnData);
                }
              } catch (e) {
                log("${'--' * 10} Error from myActionButton ${'--' * 10}\n");
                log(e.toString());
                log(widget.customErrorMessage.toString());
                log("${'--' * 10} Error from myActionButton ${'--' * 10}\n");
                if (widget.customErrorMessage != null) {
                  ('${widget.customErrorMessage}');
                } else {
                 print("Something went wrong");
                }
              }
            }

          loding = false;
          setState(() {});
        }
      },
      child: AnimatedContainer(
        curve: widget.curve ?? Curves.easeInOut,
        duration: widget.duretion ?? Duration(milliseconds: 300),
        height: widget.height??SC.from_width(46),
        // width: loding
        //     ? widget.height
        //     : widget.width ?? MediaQuery.of(context).size.width - 30,


        // width: loding
        //     ? (widget.height ?? SC.from_width(43)) // Use a default height value
        //     : (widget.width ?? MediaQuery.of(context).size.width - 30),


        width: (widget.width ?? MediaQuery.of(context).size.width - 30),
        decoration: !loding
            ? widget.decoration ??
                BoxDecoration(
                  color: AppConstant.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                    )
            :widget.activeDecoration?? BoxDecoration(
          color: AppConstant.primaryColor,
                borderRadius: BorderRadius.circular(2),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            if(loding)
              SizedBox(
                height: SC.from_width(20),
                width: SC.from_width(20),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),

            if(widget.child!=null&&loding==false)
              widget.child!,


            //
            if(widget.lable!=null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SC.from_width(8)),
                child: Text(
                  "${widget.lable}",
                  style:  TextStyle(fontWeight: FontWeight.w600,fontSize: SC.from_width(16),color: Colors.white),
                ),
              ),

            if(widget.trailingIcon!=null)
              Theme(
                data: ThemeData(
                    iconTheme: IconThemeData(color: Colors.white)
                ),
                child: widget.trailingIcon!,

              )

          ],
        ),
      ),
    );
  }
}


