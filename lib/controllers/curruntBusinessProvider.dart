
import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/CustomTextField.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/businessUpdateProvider.dart';
import 'package:fab_app/controllers/googleReviewprovider.dart';
import 'package:fab_app/controllers/google_report_detail_provider.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/controllers/homeScreenDetailProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurruntBusinessProvider with ChangeNotifier
{

  BusinessModel? _curruntBusiness;
  BusinessDetail? _detail;
  BusinessModel? get curruntBusiness =>_curruntBusiness;
  BusinessDetail? get detail =>_detail;
  bool _switch = false;
  bool get switching => _switch;





  setBusiness(BuildContext context,BusinessModel business) async
  {
    _switch = true;
    notifyListeners();



    Provider.of<KeyWordDetailProvider>(context,listen: false).setBusiness(business);
    Provider.of<ReviewProvider>(context,listen: false).setBusiness(business,
        Provider.of<AuthProvider>(context,listen: false).googleToken??'');
    Provider.of<HomeProvider>(context,listen: false).clear();
    Provider.of<GoogleReportDetailProvider>(context,listen: false).clear();
    Provider.of<BusinessUpdateProvider>(context,listen: false).setBusiness(business,
        Provider.of<AuthProvider>(context,listen: false).googleToken??'');
    _curruntBusiness = business;
    await getBusinessDetail(context);
    await DB().saveBusiness(business);



    _switch = false;
    notifyListeners();
  }


  getCurruntBusiness(BuildContext context)async
  {
    var b = await DB().getBusiness();
    if(b!=null)
      {
        await setBusiness(context, b);
      }

  }


  getBusinessDetail(BuildContext context) async
  {
    var resp =  await BusinessApis().getBusinessById(businessId: _curruntBusiness?.id??'');

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        BusinessDetailResponceModel data = BusinessDetailResponceModel.fromJson(d);
        _detail = data.data;
        notifyListeners();
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, resp.body);
        break;


      default:
        break;
    }


  }



  Future updateBusiness(BuildContext context,
      {
        String? primaryPhone,
        String? primaryCategory,
        String? address,
        DateTime? openDate,
        String? website,
        List<AdditionalCategory>? additionalCategory,
        List<KeyWordForSeo>? keyWordForSeo,
        List<RegularHour>? regularHour,
      }) async
  {

    print("Update Profile");

    var resp  = await BusinessApis().updateBusiness(
      businessId: _curruntBusiness?.id??'',
      googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
      primaryPhone: primaryPhone,
      openingDate: openDate,
      primaryCategory: primaryCategory,
      address: address,
      website: website,
      additionalCategory: additionalCategory,
      keyWordForSeo: keyWordForSeo,
      regularHour: regularHour
    );



    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        await getBusinessDetail(context);
        notifyListeners();
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, resp.body);
        break;


      default:
        break;
    }

  }



  addAdditionCategory(BuildContext context) async
  {

    TextEditingController controller = TextEditingController();

    await OpenDailovgWithAnimation(context,
        dailog: WillPopScope(
          onWillPop: ()async{
            return false;
          },

          child: Center(
            child: Card(
              color: Colors.grey.shade100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    SizedBox(height: SC.from_width(10),),
                    CustomTextField(
                      controller: controller,
                      lable: 'Additional Category',
                      hintText: 'Enter Category Name',
                    ),
                    SizedBox(height: SC.from_width(10),),

                    Row(
                      children: [

                        Expanded(child: MyactionButton(action: ()async{
                          if(controller.text.isEmpty)
                            {
                              showSnakeBar(context, message: 'Enter Category Name');
                            }
                          else
                            {
                              List<AdditionalCategory> d = [];
                              d.addAll(_detail?.additionalCategory??[]);
                              d.add(AdditionalCategory(
                                category: controller.text.trim()
                              ));

                              await updateBusiness(context,additionalCategory: d);
                              Navigator.pop(context);
                            }


                        },lable: 'Add',)),
                        SizedBox(width: SC.from_width(10),),

                        Expanded(child: MyactionButton(inversTheme: true,action: (){
                          Navigator.pop(context);
                        },lable: 'Cancel',)),

                      ],
                    )

                  ],
                ),
              ),
            ),
          ),

        ));

  }


  addKeyWordForSeo(BuildContext context) async
  {

    TextEditingController controller = TextEditingController();

    await OpenDailovgWithAnimation(context,
        dailog: WillPopScope(
          onWillPop: ()async{
            return false;
          },

          child: Center(
            child: Card(
              color: Colors.grey.shade100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    SizedBox(height: SC.from_width(10),),
                    CustomTextField(
                      controller: controller,
                      lable: 'Primary Key Word For Seo',
                      hintText: 'Enter Key Word',
                    ),
                    SizedBox(height: SC.from_width(10),),

                    Row(
                      children: [

                        Expanded(child: MyactionButton(action: ()async{
                          if(controller.text.isEmpty)
                          {
                            showSnakeBar(context, message: 'Enter Key Word');
                          }
                          else
                          {
                            List<KeyWordForSeo> d = [];
                            d.addAll(_detail?.primaryKeywordForSeo??[]);
                            d.add(KeyWordForSeo(
                                keyword: controller.text.trim()
                            ));

                            await updateBusiness(context,keyWordForSeo: d);
                            Navigator.pop(context);
                          }


                        },lable: 'Add',)),
                        SizedBox(width: SC.from_width(10),),

                        Expanded(child: MyactionButton(inversTheme: true,action: (){
                          Navigator.pop(context);
                        },lable: 'Cancel',)),

                      ],
                    )

                  ],
                ),
              ),
            ),
          ),

        ));

  }

  reqDeleteKeyWordForSeo(BuildContext context,KeyWordForSeo key) async
  {

    bool? p = await OpenDailovgWithAnimation(context, dailog: Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12),
        
        
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: SC.from_width(20),),
              Text("Delete This Key Word",style: AppConstant.labelStyl(BuildContext),),
              SizedBox(height: SC.from_width(20),),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Expanded(
                    child: MyactionButton(
                      action: ()async{
                        await _deleteKeyWordForSeo(context, key);
                        Navigator.pop(context);
                      },lable: 'Delete',),
                  ),

                  SizedBox(width: SC.from_width(10),),

                  Expanded(
                    child: MyactionButton(
                      inversTheme: true,
                      action: ()async{
                      Navigator.pop(context);
                    },lable: 'Cancle',),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    ));


  }


  reqDeleteAdditionalCategory(BuildContext context,AdditionalCategory key) async
  {

    bool? p = await OpenDailovgWithAnimation(context, dailog: Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12),


        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: SC.from_width(20),),
              Text("Delete This Additional Category",style: AppConstant.labelStyl(BuildContext),),
              SizedBox(height: SC.from_width(20),),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Expanded(
                    child: MyactionButton(
                      action: ()async{
                        await _deleteAddCategory(context, key);
                        Navigator.pop(context);
                      },lable: 'Delete',),
                  ),

                  SizedBox(width: SC.from_width(10),),

                  Expanded(
                    child: MyactionButton(
                      inversTheme: true,
                      action: ()async{
                        Navigator.pop(context);
                      },lable: 'Cancle',),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    ));


  }
  _deleteKeyWordForSeo(BuildContext context,KeyWordForSeo key) async
  {

    var resp = await BusinessApis().deleteKeyForSeo(keyWordId: key.id??'', businessId: _curruntBusiness?.id??'');


    switch(resp.statusCode)
    {
      case 200:
        await getCurruntBusiness(context);
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, resp.body);
        break;


      default:
        break;
    }

  }


  _deleteAddCategory(BuildContext context,AdditionalCategory key) async
  {

    var resp = await BusinessApis().deleteAdditionalCategory(catId: key.id??'', businessId: _curruntBusiness?.id??'');


    switch(resp.statusCode)
    {
      case 200:
        await getCurruntBusiness(context);
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, resp.body);
        break;


      default:
        break;
    }

  }



  updateRegularDay(BuildContext context,RegularHour day)async
  {

    List<RegularHour> d = [];

    _detail?.regularHours?.forEach((element) {
      if(day.day==element.day)
        {
          d.add(RegularHour(
            day: day.day,
            openingTime: day.openingTime,
            closingTime: day.closingTime,
            isOpen: !(day.isOpen??false),
            id: day.id,
          ));
        }
      else
        {
          d.add(element);
        }
    },);

    await updateBusiness(context,regularHour: d);
  }







}