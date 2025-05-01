import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/my_shimmer_widget.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/Home_sub_screens/detailed_repoty_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speedometer_chart/speedometer_chart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';




class ChartData
{
  String name;
  double value;
  Color? color;
  ChartData(
  {
    this.name='',
    this.value =0,
    this.color
}
      );
}


class GoogleDataReportWidget extends StatefulWidget {
  final bool loading;
  final bool navigate;
  GoogleDataReportWidget({this.loading = false,this.navigate = true,super.key});

  @override
  State<GoogleDataReportWidget> createState() => _GoogleDataReportWidgetState();
}

class _GoogleDataReportWidgetState extends State<GoogleDataReportWidget> {
  final colorList = [
    Color.fromRGBO(255, 51, 51, 1),
    Color.fromRGBO(255, 102, 25, 1),
    Color.fromRGBO(255, 175, 25, 1),
    Color.fromRGBO(255, 217, 25, 1),
    Color.fromRGBO(149, 223, 61, 1),
    Color.fromRGBO(0, 170, 78, 1),


  ];

  final data = [
    ChartData(
      name: 'Very Poor',
      value: 10,
      color: Color.fromRGBO(255, 51, 51, 1)
    ),

    ChartData(
      name: 'Poor',
      value: 20,
        color: Color.fromRGBO(255, 102, 25, 1)
    ),

    ChartData(
      name: 'Fair',
      value: 30,
        color: Color.fromRGBO(255, 175, 25, 1)

    ),

    ChartData(
      name: 'Good',
      value: 30,
        color: Color.fromRGBO(255, 217, 25, 1)
    ),

    ChartData(
      name: 'Very Good',
      value: 20,
      color: Color.fromRGBO(149, 223, 61, 1)
    ),

    ChartData(
        name: 'Excellent',
        value: 20,
        color: Color.fromRGBO(0, 170, 78, 1)
    ),

  ];

  PublishSubject<double> eventObservable = PublishSubject();

  double v = 0;
  @override
  Widget build(BuildContext context) {



    return MyCard(
      margin: EdgeInsets.zero,
      elevation: 4, // Adds shadow to the card
      // Adds margin around the card
      child: Consumer<HomeProvider>(
        builder: (context, p, child) {

          // if(true)
          //   {
          //     return Padding(
          //
          //       padding: const EdgeInsets.all(10),
          //       child: Shimmer(child:
          //           Center(child: Text("Loading...",style: AppConstant.labelStylTextField(BuildContext),)), gradient: LinearGradient(colors: [
          //         Colors.grey,
          //         Colors.grey.shade900
          //       ])),
          //     );
          //
          //   }
          return Column(
            children: <Widget>[
              ListTile(

                title: Text('Google Audit Score'),

                subtitleTextStyle: AppConstant.bodyText(BuildContext),
                subtitle: Text('Based on your data from google business'),
              ),

              // Text('asdf',style: TextStyle(color: Colors.black),),


              //



              MyShimmerWidget(
                loading: p.loading,
                child: SizedBox(
                  width: SC.from_width(250),
                  height: SC.from_width(125),

                  child: Stack(

                    clipBehavior: Clip.none,

                    children: [




                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  midCircle(190,
                            color: Colors.white,
                            pad: EdgeInsets.symmetric(horizontal: 15),
                            shadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius:5,
                                  color: Colors.grey
                              )
                            ],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              child: SfRadialGauge(


                                axes: [

                                  RadialAxis(

                                    startAngle: 180,
                                    endAngle: 0,
                                    showTicks: false,
                                    showLabels: false,

                                    ranges: [
                                      GaugeRange(
                                        startValue: 0,
                                        endValue: 180,

                                        startWidth: 30,
                                        endWidth: 0,

                                        gradient: SweepGradient(
                                            colors:colorList
                                        ),
                                      )
                                    ],


                                  )
                                ],

                              ),
                            )
                        ),
                      ),

                      //
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: midCircle(80,color: Colors.grey.withOpacity(.5),),
                      ),


                      //
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  midCircle(50,color: Colors.grey.withOpacity(.8),),
                      ),

                      //



                      // Image.asset('assets/auth_image/middleMeterPart.png'),
                      Positioned(

                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: SC.from_width(-125),

                        child: SfRadialGauge(



                          axes: [
                            RadialAxis(
                              interval: 30,
                              startAngle: 180,
                              endAngle: 0,
                              showTicks: false,
                              showLabels: false,
                              maximum: 180,
                              minimum: 0,

                              labelOffset:10,
                              labelFormat: '${data[0].value}',
                              labelsPosition: ElementsPosition.outside,



                              //

                              pointers: [
                                NeedlePointer(
                                  enableAnimation: true,
                                  gradient: LinearGradient(

                                      colors: [Colors.grey,Colors.grey.shade900]),
                                  value:(180/100)*(p.homeData?.data?.auditScore??0),
                                  // value:(180/100)*v,
                                  needleLength: .9,
                                  needleStartWidth: 1,
                                  needleEndWidth: SC.from_width(10),

                                  knobStyle: KnobStyle(
                                    knobRadius: 0.07, // Size of the center knob
                                    color: Colors.grey,
                                    borderColor: Colors.white,
                                    borderWidth: .05,

                                  ),
                                  needleColor: Colors.grey,
                                ),
                              ],

                              ranges: [



                                for(int i =0; i<data.length;i++)
                                  GaugeRange(
                                    startValue: i*30,
                                    endValue: ((i+1)*30)-(i==data.length-1?0:2),
                                    color: data[i].color,
                                    label: '${data[i].name}',
                                    startWidth: SC.from_width(25),
                                    endWidth: SC.from_width(25),
                                    labelStyle: GaugeTextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: SC.from_width(8)
                                    ),
                                  ),

                              ],

                            )
                          ],

                        ),
                      ),

                    ],
                  ),
                ),
              ),


              SizedBox(height: SC.from_width(20),),

              // if(kDebugMode)
              //   Column(
              //     children: [
              //       Text("${v} == ${(180/100)*v}"),
              //       Slider(
              //         max: 100,
              //           min: 1,
              //           value: v, onChanged: (nv){
              //         v= nv;
              //         setState(() {
              //
              //         });
              //       }),
              //     ],
              //   ),










              if(widget.navigate)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MyactionButton(action: (){
                    RouteTo(context, child: (p0, p1) => DetailedReportScreen(),);
                  },lable: 'Check Detailed Report',),
                ),

              //
              if(widget.navigate)
                SizedBox(height: SC.from_width(11),)

            ],
          );

        },
      )
    );
  }

Widget midCircle(double s,{Widget? child,Color? color,List<BoxShadow>? shadow,Clip clip = Clip.hardEdge,
EdgeInsets? pad })
  {

    return Container(

      width: SC.from_width(s),
      height: SC.from_width(s/2),
      child: Stack(
        clipBehavior: clip,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: SC.from_width(-s/2),
            child: Center(
              child: Padding(
                padding: pad??EdgeInsets.zero,
                child: Container(

                  height: SC.from_width(s),
                  width: SC.from_width(s),

                  child: child,
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    boxShadow: shadow
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
