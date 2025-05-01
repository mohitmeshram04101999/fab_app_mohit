import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/getcompinany%20Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class ReturnPolicyScreen extends StatefulWidget {
  const ReturnPolicyScreen({super.key});

  @override
  State<ReturnPolicyScreen> createState() => _ReturnPolicyScreenState();
}

class _ReturnPolicyScreenState extends State<ReturnPolicyScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: Text("Return Policy"),
      ),

      body: Consumer<GetCompanyProvider>(builder: (context, p, child)
      {
        if(p.loading)
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(p.data==null)
        {
          return Center(
            child:NoDataPlaceHolder(),
          );
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 20),
          children: [
            HtmlWidget(p.data?.returnPolicy??'',textStyle: TextStyle(fontFamily: 'Poppins'),)

          ],
        );

      },),
    );
  }
}
