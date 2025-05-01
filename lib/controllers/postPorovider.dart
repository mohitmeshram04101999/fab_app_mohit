

import 'dart:convert';

import 'package:fab_app/api_service/businessAPi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/postApi.dart';
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
import 'package:fab_app/screens/profileScreens/post_sub_screen/add%20event%20Screen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostProvider with ChangeNotifier
{

  final _api = PostApi();

  List<Post> _post = [];
  bool _loadin = true;
  bool _loadinMore = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedImage;
  Subscription? _subscription;

  int _page = 1;


  List<Post> get post =>_post;
  bool get loading =>_loadin;
  bool get loadMore =>_loadinMore;
  TextEditingController get titleController =>_titleController;
  TextEditingController get  descriptionController =>_discController ;
  String? get selectedImage => _selectedImage;
  DateTime? get startDate =>_startDate;
  DateTime? get endDate =>_endDate;
  Subscription? get sub => _subscription;

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

  selectStartDate(BuildContext context)async
  {

  var d =  await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000));
  if(d!=null)
    {
      _startDate = d;
      notifyListeners();
    }
  }

  selectEndDate(BuildContext context)async
  {

    var d =  await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000));
    if(d!=null)
    {
      _endDate = d;
      notifyListeners();
    }
  }

  clearFields()
  {
    _selectedImage = null;
    _titleController.clear();
    _discController.clear();
    _startDate = null;
    _endDate = null;
  }


  //
  createPost(BuildContext context) async
  {
    if(_titleController.text.trim().isEmpty||
        _selectedImage==null||
        _discController.text.trim().isEmpty||
    _startDate==null||
    _endDate ==null
    )
    {

      showSnakeBar(context, message: "Provide All Details Of Your Post",color: Colors.red);
      return ;

    }

    var resp = await _api.createPost(
        title: _titleController.text.trim(),
        eventSummary: _discController.text.trim(),
        image: _selectedImage??"",
        startDate: _startDate!,
        endDate: _endDate!,
        googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
        businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??''
    );


    switch(resp.statusCode)
    {
      case 201:
        var d = jsonDecode( await resp.body);
        var p = Post.fromJson(d['data']);
        _post.add(p);
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

  editMode(BuildContext context,Post p)
  {
    if(_subscription?.planDetails?.productManagement==false||_subscription?.isPlanExpired==true)
    {
      premiumPopUp(context);
      return;
    }
    _titleController.text = p.eventTitle??'';
    _discController.text = p.eventSummary??'';
    _startDate = p.startDate;
    _endDate = p.endDate;
    RouteTo(context, child: (p0, p1) => AddEventScreen(editMode: true,post: p,),);
  }

  //

  updatePost(BuildContext context,Post p) async
  {

    if(
    _titleController.text.trim().isEmpty||
        _discController.text.trim().isEmpty||
        _startDate==null||
        _endDate ==null
    )
    {

      showSnakeBar(context, message: "Provide All Details Of Your Post",color: Colors.red);
      return ;

    }

    var resp = await _api.update(

        title: _titleController.text.trim(),
        eventSummary: _discController.text.trim(),
        image: _selectedImage,
        endDate: _endDate!,
        startDate: _startDate!,
        googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
        businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??'',
      gbmPostID: p.gmbPostId??'',
    );


    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode( await resp.body);
        var p = Post.fromJson(d['data']);
        for(int i=0;i<_post.length;i++)
        {
          if(_post[i].id==p.id)
          {
            _post.removeAt(i);
            _post.insert(i, p);
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

  requestDelete(BuildContext context,Post post) async
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
            await deletePost(context, post);
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


  deletePost(BuildContext context,Post p) async
  {
    var resp = await _api.deletePost(
  gbmPostId: p.gmbPostId??'',
    googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
  businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??'',
    );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode( await resp.body);
        _post.removeWhere((element) => p.id==element.id,);
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





  getAllPost(BuildContext context) async
  {

    _page = 1;
    _post = [];
    _loadin = true;

    BusinessModel? b =  await DB().getBusiness();
    var resp = await _api.getAllPost(businessId:b?.id??'' );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        List data = d['data'];
        _post = data.map((e) => Post.fromJson(e),).toList();
        if(_post.isNotEmpty)
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
    var resp = await _api.getAllPost(businessId:b?.id??'',page: _page);

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        List data = d['data'];
        var newData = data.map((e) => Post.fromJson(e),).toList();
        if(newData.isNotEmpty)
        {
          _post.addAll(newData);
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