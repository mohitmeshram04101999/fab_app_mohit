import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fab_app/componenet/HelpButtom.dart';
import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/componenet/profile_tile.dart';
import 'package:fab_app/componenet/selection_button.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/copi_analisis.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/engage_graph_widget.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/feture_grid_view.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/google%20Report%20widget.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/keyword_widget_home.dart';
import 'package:fab_app/screens/Home_sub_screens/ratingscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Connectivity connectivity = Connectivity();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var home = Provider.of<HomeProvider>(context,listen: false);
    home.getHomeData(context);


  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      
      onRefresh: ()async{
        await Provider.of<HomeProvider>(context,listen: false).getHomeData(context);
      },
      
      child: MyScaffold(
      
      
      
        // floatingActionButton: kDebugMode?FloatingActionButton(onPressed: (){
        //   var user = Provider.of<AuthProvider>(context,listen: false).user;
        //   var home = Provider.of<HomeProvider>(context,listen: false);
        //   home.getHomeData(context);
        //
        //
        //   print("id = ${user?.id} \ntoken =  ${user?.token}");
        //
        // }):null,
      
        floatingActionButton: HelpButtom(),
      
        body: Consumer<HomeProvider>(
          builder: (context, p, child) => ListView(
      
            
            padding: EdgeInsets.only(bottom: SC.from_width(20),top: SC.from_width(15)) ,
      
            children: [
      
              
      
      
              //profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ProfileTile(),
              ),
      
              SizedBox(height: SC.from_width(15),),
      
              //google report Widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GoogleDataReportWidget(
                  loading: p.loading,
                ),
              ),
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
                  onTap: (){
                    RouteTo(context, child: (p0, p1) => RatingScreen(),);
                  },
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

                    Share.share("down this all https://pub.dev/packages/share_plus",subject: "thi it is sadkdfla");
                  },
                  lable: 'Share',
                  trailingIcon: Icon(Icons.share),
                ),
              ),
      
      
      
      
      
      
      
      
      
            ],
          ),
        ),
      
      ),
    );
  }
}
