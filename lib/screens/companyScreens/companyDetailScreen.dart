import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/getcompinany%20Controller.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/companyScreens/aboutUs.dart';
import 'package:fab_app/screens/companyScreens/privecy_policy.dart';
import 'package:fab_app/screens/companyScreens/returnPolicy.dart';
import 'package:fab_app/screens/companyScreens/terms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CompanyDetailScreen extends StatefulWidget {
  const CompanyDetailScreen({super.key});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetCompanyProvider>(context,listen: false).getCompany(context);
  }

  @override
  Widget build(BuildContext context) {
    return  MyScaffold(


      appBar: AppBar(
        elevation: 0,
        leading: SizedBox(),
      ),

      body: Consumer<GetCompanyProvider>(builder:
      (context, p, child) {

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
          child: Column(
            children: [
              
              Container(
                clipBehavior: Clip.hardEdge,
                height: SC.from_width(100),
                width: SC.from_width(100),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle
                ),
                child: Image.network('${MyUrl.base}${p.data?.logo??''}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(30),),
                ),
              ),
              
              SizedBox(height: SC.from_width(20),),

              Text("${p.data?.name??''}",style: AppConstant.labelStyle2(BuildContext),),
              SizedBox(height: SC.from_width(8),),


              Text("${p.data?.email??''}",style: AppConstant.font_500_14(BuildContext).copyWith(color: Colors.grey.shade500),),
              SizedBox(height: SC.from_width(8),),


              Text("Website :- ${p.data?.website??''}",style: AppConstant.font_500_14(BuildContext).copyWith(color: Colors.grey.shade500),),
              SizedBox(height: SC.from_width(8),),
              Text("Address :- ${p.data?.address??''}",style: AppConstant.font_500_14(BuildContext).copyWith(color: Colors.grey.shade500),),
              SizedBox(height: SC.from_width(30),),

              ListTile(
                minTileHeight: SC.from_width(50),
                trailing: Icon(Icons.arrow_forward_ios,size: SC.from_width(16),color:AppConstant.primaryColor ,),
                onTap: (){
                  RouteTo(context, child: (p0, p1) => TermsAndConditionScreen(),);
                },
                title: Text("Terms And Condition",style: AppConstant.labelStyle2(BuildContext).copyWith(fontWeight: FontWeight.w500),),
              ),

              ListTile(
                minTileHeight: SC.from_width(50),
                trailing: Icon(Icons.arrow_forward_ios,size: SC.from_width(16),color:AppConstant.primaryColor ,),
                onTap: (){
                  RouteTo(context, child: (p0, p1) => PrivecyPolicyScreen(),);
                },
                title: Text("Privecy Policy",style: AppConstant.labelStyle2(BuildContext).copyWith(fontWeight: FontWeight.w500),),
              ),

              ListTile(
                minTileHeight: SC.from_width(50),
                trailing: Icon(Icons.arrow_forward_ios,size: SC.from_width(16),color:AppConstant.primaryColor ,),
                onTap: (){
                  RouteTo(context, child: (p0, p1) => ReturnPolicyScreen(),);
                },
                title: Text("Return Policy",style: AppConstant.labelStyle2(BuildContext).copyWith(fontWeight: FontWeight.w500),),
              ),



              ListTile(
                minTileHeight: SC.from_width(50),
                trailing: Icon(Icons.arrow_forward_ios,size: SC.from_width(16),color:AppConstant.primaryColor ,),
                onTap: (){
                  RouteTo(context, child: (p0, p1) => AboutUsScreen(),);
                },
                title: Text("About Us",style: AppConstant.labelStyle2(BuildContext).copyWith(fontWeight: FontWeight.w500),),
              ),

            ],
          ),
        );
        },),

    );
  }
}
