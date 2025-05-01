
import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier
{


  List<Product> _product = [];
  bool _loadin = true;
  bool _loadinMore = false;
  Subscription? _subscription;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discController = TextEditingController();
  String? _selectedImage;
  int _page = 1;


  List<Product> get product =>_product;
  bool get loading =>_loadin;
  bool get loadMore =>_loadinMore;
   TextEditingController get titleController =>_titleController;
   TextEditingController get  descriptionController =>_discController ;
   String? get selectedImage => _selectedImage;
  Subscription? get subscription =>_subscription;

  setUser(User user)
  {
    _subscription = user.subscription;
  }


   selectImage(BuildContext context)async
   {
      var result = await ImagePicker().pickImage(source: ImageSource.gallery,);
      if(result!=null)
        {
          _selectedImage = result.path;
          notifyListeners();
        }
   }

   clearFields()
   {
     _selectedImage = null;
     _titleController.clear();
     _discController.clear();
   }


   createProduct(BuildContext context) async
   {
     if(_titleController.text.trim().isEmpty||_selectedImage==null||_discController.text.trim().isEmpty)
       {

         showSnakeBar(context, message: "Provide All Details Of Your Product",color: Colors.red);
         return ;

       }

     var resp = await BusinessApis().addProduct(
         title: _titleController.text.trim(),
         description: _discController.text.trim(),
         image: _selectedImage??"",
         businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??''
     );


     switch(resp.statusCode)
     {
       case 200:
         var d = jsonDecode( await resp.body);
         var p = Product.fromJson(d['data']);
         _product.add(p);
         clearFields();
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

   editMode(BuildContext context,Product p)
   {
     if(_subscription?.planDetails?.productManagement==false||_subscription?.isPlanExpired==true)
       {
         premiumPopUp(context);
         return;
       }

     _titleController.text = p.title??'';
     _discController.text = p.description??'';
     RouteTo(context, child: (p0, p1) => AddProductScreen(editMode: true,product: p,),);
   }

   updateProduct(BuildContext context,Product p) async
   {



     if(_titleController.text.trim().isEmpty||_discController.text.trim().isEmpty)
     {

       showSnakeBar(context, message: "Provide All Details Of Your Product",color: Colors.red);
       return ;

     }

     var resp = await BusinessApis().update(
         title: _titleController.text.trim(),
         description: _discController.text.trim(),
         image: _selectedImage,
         gmbProductId: p.gmbProductId??''
     );


     switch(resp.statusCode)
     {
       case 200:
         var d = jsonDecode( await resp.body);
         var p = Product.fromJson(d['data']);
         for(int i=0;i<_product.length;i++)
           {
             if(_product[i].id==p.id)
               {
                 _product.removeAt(i);
                 _product.insert(i, p);
               }
           }
         clearFields();
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


  requestDelete(BuildContext context,Product post) async
  {


    if(_subscription?.planDetails?.productManagement==false||_subscription?.isPlanExpired==true)
    {
      premiumPopUp(context);
      return;
    }

    bool? p = await OpenDailovgWithAnimation(context, dailog: AlertDialog(

      title: Text("Delete This Post"),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          MyactionButton(
            color: Colors.red,
            action: ()async{
              await deleteProvider(context, post);
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


   deleteProvider(BuildContext context,Product p) async
   {
     var resp = await BusinessApis().deleteProduct(gmbProductId: p.gmbProductId??'');

     switch(resp.statusCode)
     {
       case 200:
         var d = jsonDecode( await resp.body);
         _product.removeWhere((element) => p.id==element.id,);
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





  getAllProduct(BuildContext context) async
  {

    _page = 1;
    _product = [];

    _loadin = true;

    BusinessModel? b =  await DB().getBusiness();
    var resp = await BusinessApis().getAllProduct(businessId:b?.id??'' );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        List data = d['data'];
        _product = data.map((e) => Product.fromJson(e),).toList();
        if(_product.isNotEmpty)
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

  getMoreProduct(BuildContext context) async
  {

    _loadin = true;

    BusinessModel? b =  await DB().getBusiness();
    var resp = await BusinessApis().getAllProduct(businessId:b?.id??'' );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        List data = d['data'];
        var newData = data.map((e) => Product.fromJson(e),).toList();
        if(newData.isNotEmpty)
        {
          _product.addAll(newData);
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



}