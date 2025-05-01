import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class MyShimmerWidget extends StatelessWidget {
  final bool loading;
  final Widget child;
  const MyShimmerWidget({required this.child,this.loading=false,super.key});

  @override
  Widget build(BuildContext context) {
    if(loading)
      {
        return Shimmer(child: child, gradient: LinearGradient(colors: [
          Colors.grey,
          Colors.grey.shade900,
        ]));
      }
    else{
      return child;
    }
  }
}
