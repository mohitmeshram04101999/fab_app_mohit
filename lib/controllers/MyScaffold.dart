import 'package:fab_app/controllers/internetProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MyScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color?  backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const MyScaffold({
    this.bottomNavigationBar,
    this.backgroundColor,
    this.body,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.appBar,super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InterNetProvider>(

      builder:(context, p, child) => Stack(
        children: [




          Scaffold(
            backgroundColor:backgroundColor ,
            appBar: appBar,
            body: body,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            bottomSheet: bottomSheet,
            bottomNavigationBar: bottomNavigationBar,
          ),



          if(p.noEnternet)
            Positioned(
                top: 0,
                bottom: 0,left: 0,right: 0,
                child: Card(child: Center(
                  child: Image.asset("assets/icons/noIntrnate.gif"),
                ),)),


        ],
      ),
    );
  }
}
