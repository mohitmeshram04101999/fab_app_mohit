import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/detailReportTile.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/primiuam_perches_message_widget.dart';
import 'package:fab_app/componenet/scaffold_for_pimium.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/google_report_detail_provider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/detaildReportTiledata.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/screens/DasnBoard/Home/homebodywidget/google%20Report%20widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailedReportScreen extends StatefulWidget {
  DetailedReportScreen({super.key});

  @override
  State<DetailedReportScreen> createState() => _DetailedReportScreenState();
}

class _DetailedReportScreenState extends State<DetailedReportScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GoogleReportDetailProvider>(context,listen: false).getReport(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(


      bottomSheet:Consumer<GoogleReportDetailProvider>(builder: (context, p, child) {

        if((p.user?.subscription?.isPlanExpired==false)&&(p.user?.subscription?.planDetails?.detailedReport==true))
          {
            return SizedBox();
          }
           return PremiumPerchesMessageWidget(
             onReturn: (){p.upDate();},
           );
      },),



      appBar: AppBar(
        title: Text("Detailed Report"),
      ),




      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),

        //
        children: [

          GoogleDataReportWidget(navigate: false,),
          SizedBox(height: SC.from_width(20),),


          Consumer<GoogleReportDetailProvider>(
            builder: (context, p, child) {
              if(p.loading)
                {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              if(p.data.isEmpty)
                {
                  return Center(
                    child: NoDataPlaceHolder(),
                  );
                }

              return ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:p.data.length,
                itemBuilder: (context, i) =>Padding(
                  padding:  EdgeInsets.only(bottom:SC.from_width(12)),
                  child: DetailReportListTile(
                    active:i<3||(p.user?.subscription?.isPlanExpired==false&&p.user?.subscription?.planDetails?.detailedReport==true),
                      data: p.data[i]),
                ) ,
              );
            },
          )

        ],

      ),


    );
  }
}
