import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/componenet/selection_button.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/copi_analisis.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/engage_graph_widget.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/feture_grid_view.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/google%20Report%20widget.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/keyword_widget_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String grafType = 'Monthly';


  List<String> typs = [
    'Monthly',
    'Weekly',
    'Daily',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("data"),
      ),
      
      
      
      body: ListView(
        
        padding: EdgeInsets.only(bottom: SC.from_width(20)) ,
        
        children: [
          
          
          //profile
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10),
            elevation: 1,
            child: ListTile(
              
              //
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text("0011223344"),
              
              subtitle: Text("xyz@gmail.com"),
            ),
          ),
          SizedBox(height: SC.from_width(15),),

          //google report Widget
          GoogleDataReportWidget(),
          SizedBox(height: SC.from_width(25),),


          //Fetere grid
          FetureInfoGridView(),
          SizedBox(height: SC.from_width(25),),

          //keyWord
          KeywordWidgetHome(),
          SizedBox(height: SC.from_width(10),),

          //campainanalysis
          CompetitorAnalysisCard(),
          
          //
          SizedBox(height: SC.from_width(38),),

          //Engemnet graph
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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


          //
          EngageGraphWidget(),
          SizedBox(height: SC.from_width(32),),
          
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Short on Time? Use our AI Feature",style: AppConstant.richInfoTextLabel(BuildContext),),
          ),
          SizedBox(height: SC.from_width(10),),

          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton2(
              label: 'Reply With AI',
            ),
          ),
          SizedBox(height: SC.from_width(10),),



          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyactionButton(
              activeDecoration: BoxDecoration(
                  color: AppConstant.primaryColor,
                  borderRadius: BorderRadius.circular(8)
              ),
              decoration: BoxDecoration(
                color: AppConstant.primaryColor,
                borderRadius: BorderRadius.circular(8)
              ),
              action: ()async{

                await Future.delayed(Duration(seconds: 1));
              },
              lable: 'Start',
              trailingIcon: Icon(Icons.arrow_forward),
            ),
          ),








          
        ],
      ),

    );
  }
}
