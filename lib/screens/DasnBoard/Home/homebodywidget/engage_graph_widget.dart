import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/selection_button.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EngageGraphWidget extends StatefulWidget {
   EngageGraphWidget({super.key});

  @override
  State<EngageGraphWidget> createState() => _EngageGraphWidgetState();
}

class _EngageGraphWidgetState extends State<EngageGraphWidget> {
  var data = [
    ChartData('Jan', 32),
    ChartData('Feb', 21),
    ChartData('Mar', 28),
    ChartData('Apr', 32),
    ChartData('May', 20)
  ];

  var data2 = [
    ChartData('Jan', 10),
    ChartData('Feb', 12),
    ChartData('Mar', 0),
    ChartData('Apr', 14),
    ChartData('May', 13)
  ];

  String grafType = 'Monthly';


  List<String> typs = [
    'Monthly',
    'Weekly',
    // 'Daily',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, p, child) =>  Column(
        children: [


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for(var i in typs)
                  SelectionButton(
                      onTap: (){
                        grafType  =i;
                        setState(() {});
                      },
                      active: grafType  ==i,
                      lable: i),
              ],),
          ),

          SizedBox(height: SC.from_width(20),),

          MyCard(
            elevation: 4,
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SC.from_width(14),),

                    Text("Views Engagement Graphs",style: AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),),
                    SizedBox(height: SC.from_width(31),),

                    if(grafType=='Monthly')
                      SizedBox(
                        height: SC.from_width(200),
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                // color: Colors.grey,
                                // color: Colors.grey,

                                child: LineChart(


                                  LineChartData(
                                      titlesData: FlTitlesData(

                                        show: true,

                                        rightTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) => Text(""),
                                                reservedSize: SC.from_width(30)
                                            )
                                        ),

                                        topTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            )
                                        ),

                                        bottomTitles: AxisTitles(
                                            drawBelowEverything: false,
                                            axisNameSize: 50,
                                            sideTitles: SideTitles(
                                              reservedSize: 40,
                                              interval: 1,
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) => SideTitleWidget(child: Text("${p.homeData?.data?.monthly?[value.toInt()].month}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(
                                                  fontSize: SC.from_width(10)
                                              ),), meta: meta),
                                            )
                                        ),



                                        leftTitles: AxisTitles(

                                          // axisNameSize: SC.from_width(30),
                                            sideTitles: SideTitles(
                                              reservedSize: SC.from_width(45),
                                              minIncluded: false,
                                              maxIncluded: false,
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) => SideTitleWidget(child: Text("${value.toInt()}"), meta: meta),
                                            )
                                        ),


                                      ),

                                      borderData: FlBorderData(
                                          border: Border(
                                              left: BorderSide(),
                                              bottom: BorderSide()
                                          )
                                      ),

                                      gridData: FlGridData(
                                          show: true,
                                          drawHorizontalLine: true,
                                          drawVerticalLine: false

                                      ),

                                      //


                                      lineBarsData: [


                                        LineChartBarData(

                                            lineChartStepData: LineChartStepData(
                                                stepDirection: 10
                                            ),

                                            spots: [
                                              for(int i =0;i<(p.homeData?.data?.monthly??[]).length;i++)
                                                FlSpot(i.toDouble(),p.homeData?.data?.monthly?[i].view?.toDouble()??0)
                                            ],
                                            isCurved: true,
                                            color: AppConstant.primaryColor,

                                            dotData: FlDotData(
                                                show: false
                                            ),


                                            belowBarData: BarAreaData(
                                                show: true,
                                                color: AppConstant.primaryColor.withOpacity(.3)
                                            ),

                                            aboveBarData: BarAreaData(
                                                show: false
                                            )
                                        ),

                                        LineChartBarData(


                                            spots: [
                                              for(int i =0;i<(p.homeData?.data?.monthly??[]).length;i++)
                                                FlSpot(i.toDouble(),p.homeData?.data?.monthly?[i].engagement?.toDouble()??0)
                                            ],
                                            isCurved: true,
                                            color: Colors.red,

                                            dotData: FlDotData(
                                                show: false
                                            ),


                                            belowBarData: BarAreaData(
                                                show: true,
                                                color: Colors.red.withOpacity(.3)
                                            ),

                                            aboveBarData: BarAreaData(
                                                show: false
                                            )
                                        )
                                      ]

                                  ),



                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    if(grafType=='Weekly')
                      SizedBox(
                        height: SC.from_width(200),
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                // color: Colors.grey,
                                // color: Colors.grey,

                                child: LineChart(


                                  LineChartData(
                                      titlesData: FlTitlesData(

                                        show: true,

                                        rightTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) => Text(""),
                                                reservedSize: SC.from_width(30)
                                            )
                                        ),

                                        topTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            )
                                        ),

                                        bottomTitles: AxisTitles(
                                            drawBelowEverything: false,
                                            axisNameSize: 50,
                                            sideTitles: SideTitles(
                                              reservedSize: 40,
                                              interval: 1,
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) => SideTitleWidget(child: Text("${p.homeData?.data?.weekly?[value.toInt()].day}".substring(0,3),style: AppConstant.richInfoTextLabel(BuildContext).copyWith(
                                                  fontSize: SC.from_width(10)
                                              ),), meta: meta),
                                            )
                                        ),



                                        leftTitles: AxisTitles(

                                          // axisNameSize: SC.from_width(30),
                                            sideTitles: SideTitles(
                                              reservedSize: SC.from_width(45),
                                              minIncluded: false,
                                              maxIncluded: false,
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) => SideTitleWidget(child: Text("${value.toInt()}"), meta: meta),
                                            )
                                        ),


                                      ),

                                      borderData: FlBorderData(
                                          border: Border(
                                              left: BorderSide(),
                                              bottom: BorderSide()
                                          )
                                      ),

                                      gridData: FlGridData(
                                          show: true,
                                          drawHorizontalLine: true,
                                          drawVerticalLine: false

                                      ),

                                      //


                                      lineBarsData: [


                                        LineChartBarData(

                                            lineChartStepData: LineChartStepData(
                                                stepDirection: 10
                                            ),

                                            spots: [
                                              for(int i =0;i<(p.homeData?.data?.weekly??[]).length;i++)
                                                FlSpot(i.toDouble(),p.homeData?.data?.weekly?[i].view?.toDouble()??0)
                                            ],
                                            isCurved: true,
                                            color: AppConstant.primaryColor,

                                            dotData: FlDotData(
                                                show: false
                                            ),


                                            belowBarData: BarAreaData(
                                                show: true,
                                                color: AppConstant.primaryColor.withOpacity(.3)
                                            ),

                                            aboveBarData: BarAreaData(
                                                show: false
                                            )
                                        ),

                                        LineChartBarData(


                                            spots: [
                                              for(int i =0;i<(p.homeData?.data?.weekly??[]).length;i++)
                                                FlSpot(i.toDouble(),p.homeData?.data?.weekly?[i].engagement?.toDouble()??0)
                                            ],
                                            isCurved: true,
                                            color: Colors.red,

                                            dotData: FlDotData(
                                                show: false
                                            ),


                                            belowBarData: BarAreaData(
                                                show: true,
                                                color: Colors.red.withOpacity(.3)
                                            ),

                                            aboveBarData: BarAreaData(
                                                show: false
                                            )
                                        )
                                      ]

                                  ),



                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          color: AppConstant.primaryColor,
                          height: 12,
                          width: 12,
                          margin: EdgeInsets.only(right: 3),
                        ),
                        Text("Views" ,style: AppConstant.richInfoTextLabel(BuildContext),),
                        
                        SizedBox(width: SC.from_width(8),),

                        Container(
                          color: Colors.red,
                          height: 12,
                          width: 12,
                          margin: EdgeInsets.only(right: 3),
                        ),
                        Text("Engagement" ,style: AppConstant.richInfoTextLabel(BuildContext),),
                        
                        

                      ],
                    ),
                    
                    SizedBox(height: SC.from_width(10),)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}




class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}