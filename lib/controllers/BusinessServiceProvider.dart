

import 'dart:convert';



import 'package:fab_app/api_service/businessServiceApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/CustomTextField.dart';

import 'package:fab_app/componenet/snake_bar/snake_bar.dart';

import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';

import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BusinessServiceProvider with ChangeNotifier
{

  final _api = BusinessServiceApi();

  List<BusinessService> _service = [];
  bool _loadin = true;
  bool _loadinMore = false;
  String? _selectedMedia;
  Subscription? _subscription;
  int _page = 1;


  List<BusinessService> get service =>_service;
  bool get loading =>_loadin;
  bool get loadMore =>_loadinMore;
  String? get selectedMedia => _selectedMedia;
  Subscription? get sub => _subscription;




  setUser(User user)
  {
    _subscription = user.subscription;
  }



  clearFields()
  {
    _selectedMedia = null;
  }


  addService(BuildContext context) async
  {
    if(_subscription?.planDetails?.productManagement==false||_subscription?.isPlanExpired==true)
    {
      premiumPopUp(context);
      return;
    }

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
                      lable: 'Service',
                      hintText: 'Enter Service Name',
                    ),
                    SizedBox(height: SC.from_width(10),),

                    Row(
                      children: [

                        Expanded(child: MyactionButton(action: ()async{
                          if(controller.text.isEmpty)
                          {
                            showSnakeBar(context, message: 'Enter Service Name');
                          }
                          else
                            {
                              await _addService(context, controller.text.trim());
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

  //
  _addService(BuildContext context,String service) async
  {


    var resp = await _api.addService(

      businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??'',
      googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
      serviceData: service,
    );



    switch(resp.statusCode)
    {
      case 201:
        var d = jsonDecode( await resp.body);
        var p = BusinessService.fromJson(d['data']);
        _service.add(p);
        clearFields();
        notifyListeners();
        showSnakeBar(context, message: "${d['message']}");
        Navigator.pop(context);
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(await resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(await resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, await resp.body);
        break;


      default:
        break;
    }

  }

  //
  requestDelete(BuildContext context,BusinessService s) async
  {

    if(_subscription?.planDetails?.productManagement==false||_subscription?.isPlanExpired==true)
    {
      premiumPopUp(context);
      return;
    }

    bool? p = await OpenDailovgWithAnimation(context, dailog: AlertDialog(

      title: Text("Delete This Media"),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          MyactionButton(
            color: Colors.red,
            action: ()async{
              await _deleteService(context, s);
              Navigator.pop(context);
            },lable: 'Delete',),

          SizedBox(height: SC.from_width(10),),

          MyactionButton(action: ()async{
            Navigator.pop(context);
          },lable: 'Cancle',),

        ],
      ),
    ));

  }

  //
  _deleteService(BuildContext context,BusinessService p) async
  {
    var resp = await _api.deleteService(
      gbmPostId: p.id??'',
      googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
      businessId: p.businessId??'',
    );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode( await resp.body);
        _service.removeWhere((element) => p.id==element.id,);
        notifyListeners();
        showSnakeBar(context, message: "${d['message']}");
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(await resp.body)['message']}');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(await resp.body)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, await resp.body);
        break;


      default:
        break;
    }


  }





  getAllService(BuildContext context) async
  {

    _page = 1;
    _service = [];
    _loadin = true;

    BusinessModel? b =  await DB().getBusiness();
    var resp = await _api.getAllService(businessId:b?.id??'' );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        List data = d['data'];
        _service = data.map((e) => BusinessService.fromJson(e),).toList();
        if(_service.isNotEmpty)
        {
          _page ++;
        }

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

    _loadin = false;
    notifyListeners();


  }

// getMoreProduct(BuildContext context) async
// {
//
//   _loadin = true;
//
//   BusinessModel? b =  await DB().getBusiness();
//   var resp = await _api.getAllPost(businessId:b?.id??'',page: _page);
//
//   switch(resp.statusCode)
//   {
//     case 200:
//       var d = jsonDecode(resp.body);
//       List data = d['data'];
//       var newData = data.map((e) => Post.fromJson(e),).toList();
//       if(newData.isNotEmpty)
//       {
//         _post.addAll(newData);
//         _page ++;
//       }
//
//       break;
//
//
//     case 404:
//       showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
//       break;
//
//     case 400:
//       showSnakeBar(context, color: Colors.red,message: '${jsonDecode(resp.body)['message']}');
//       break;
//
//     case 401:
//       tokeExpire(context);
//       break;
//
//     case 500:
//       serverErrorWidget(context, resp.body);
//       break;
//
//
//     default:
//       break;
//   }
//
//   _loadin = false;
//   notifyListeners();
//
// }

}