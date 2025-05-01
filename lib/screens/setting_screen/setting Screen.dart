import 'package:fab_app/componenet/HelpButtom.dart';
import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/business_tile_2.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/businessControllers.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/companyScreens/aboutUs.dart';
import 'package:fab_app/screens/companyScreens/companyDetailScreen.dart';
import 'package:fab_app/screens/companyScreens/privecy_policy.dart';
import 'package:fab_app/screens/companyScreens/returnPolicy.dart';
import 'package:fab_app/screens/companyScreens/terms_and_condition.dart';
import 'package:fab_app/screens/packageScreens/all_plan_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BusinessProvider>(context,listen: false).load(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      //



      //
      floatingActionButton: HelpButtom(),


      body: Consumer<BusinessProvider>(builder: (context, p, child) {


        return RefreshIndicator(
          onRefresh: ()async{
            await p.load(context);
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 13,vertical: 10),
            children: [

              MyCard(
                color: Colors.grey.shade50,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: SC.from_width(10),),
                      Text("Business",style: AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),),

                      //
                      Text("Manage your google listing",style: AppConstant.richInfoTextLabel(BuildContext),),


                      if(p.loading)...[
                        Center(child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        )),
                      ]
                        else if(p.allBusiness.isEmpty)...[
                          Center(
                            child: NoDataPlaceHolder(),
                          )
                      ]
                      else...[
                        for(BusinessModel b in p.allBusiness)
                          Padding(
                            padding: EdgeInsets.only(top: SC.from_width(8)),
                            child: BusinessTile2(business: b),
                          ),
                      ],




                      SizedBox(height: SC.from_width(15),)
                    ],
                  ),
                ),
              ),

              SizedBox(height: SC.from_width(30),),
              MyactionButton(action: ()async{
                await Provider.of<AuthProvider>(context,listen: false).logOut(context);
              },lable: 'Logout',
                trailingIcon: Icon(Icons.logout),),


              SizedBox(height: SC.from_width(15),),
              MyactionButton(action: (){},
                lable: 'Facebook',
                trailingIcon: Icon(Icons.arrow_forward),
              ),


              SizedBox(height: SC.from_width(15),),
              MyactionButton(action: (){
                RouteTo(context, child: (p0, p1) => CompanyDetailScreen(),);
              },
                lable: 'Company Detail',
              ),


              //
              SizedBox(height: SC.from_width(15),),
              MyactionButton(action: (){
                RouteTo(context, child: (p0, p1) => AllPlanScreen(),);
              },
                lable: 'Subscription',
              ),


            ],
          ),
        );

      },),

    );
  }
}
