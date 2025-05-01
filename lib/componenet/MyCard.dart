import 'package:flutter/material.dart';


class MyCard extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double elevation;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? color;
  const MyCard({this.color,this.borderRadius,this.elevation=2,this.margin,this.child,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: margin??EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: color??Colors.white ,
        borderRadius: borderRadius??BorderRadius.circular(8),

        boxShadow: [
          BoxShadow(
            spreadRadius: elevation,
            blurRadius: elevation*1.7,
            // offset: Offset(elevation, elevation),
            color: Colors.grey.shade300
          )
        ]
      ),

      child:Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius??BorderRadius.circular(5)
        ),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
          child: child),
    );
  }
}
