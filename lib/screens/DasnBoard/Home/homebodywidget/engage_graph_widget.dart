import 'package:fab_app/consgt/constWar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EngageGraphWidget extends StatelessWidget {
   EngageGraphWidget({super.key});


  var data = [
    ChartData('Jan', 35),
    ChartData('Feb', 28),
    ChartData('Mar', 34),
    ChartData('Apr', 32),
    ChartData('May', 40)
  ];

  var data2 = [
    ChartData('Jan', 10),
    ChartData('Feb', 12),
    ChartData('Mar', 13),
    ChartData('Apr', 14),
    ChartData('May', 13)
  ];
  @override
  Widget build(BuildContext context) {
    return Card(child: Center(
      child: SfFunnelChart(




        // selectionType: SelectionType.series,
        //
        // primaryXAxis: CategoryAxis(
        // ),
        //
        //
        // primaryYAxis: NumericAxis(
        // ),
        // Add a line series


        series:FunnelSeries(

          dataSource: <ChartData>[
            ChartData('Jan', 35),
            ChartData('Feb', 28),
            ChartData('Mar', 34),
            ChartData('Apr', 32),
            ChartData('May', 40)
          ],
        ),
      ),
    )
    );
  }
}




class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}