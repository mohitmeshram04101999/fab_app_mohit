import 'package:carousel_slider/carousel_slider.dart';
import 'package:fab_app/componenet/PlanTIle.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/plan_provider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/getAllPlanResponceModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AllPlanScreen extends StatefulWidget {
  const AllPlanScreen({super.key});

  @override
  State<AllPlanScreen> createState() => _AllPlanScreenState();
}

class _AllPlanScreenState extends State<AllPlanScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PlanProvider>(context,listen: false).getAllPlan(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      
      appBar: AppBar(
        title: Text("Purchase Plan"),
      ),
      
      
      body: Consumer<PlanProvider>(builder: (context, p, child) {
        if(p.loading)
          {
            return Center(
            child: CircularProgressIndicator(),
            );
          }
        if(p.plans.isEmpty)
          {
            return Center(
            child: NoDataPlaceHolder(),
            );
          }
        
        return RefreshIndicator(
          onRefresh: () async{
            await p.getAllPlan(context);
          },

          // child: ListView.builder(
          //   padding: EdgeInsets.symmetric(horizontal: 12,vertical: 20),
          // itemCount: p.plans.length,
          //     itemBuilder: (context, i) =>  PlanTile(plan: p.plans[i]),
          // ),

          child: Padding(
            padding: EdgeInsets.only(
              top: SC.from_width(50)
            ),
            child: CarouselSlider(
            
              options: CarouselOptions(
                viewportFraction: .8,
                enlargeCenterPage: true,
                height:SC.Screen_width*1.3,
                enableInfiniteScroll: false,
                autoPlay: false
              ),
            
                items: List.generate(p.plans.length, (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: PlanTile(plan: p.plans[i]),
                ),), ),
          ),

        );
        
      },



      
    ));
  }
}
