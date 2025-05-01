

import 'dart:convert';
import 'dart:io';


import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/media%20api.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/video_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaProvider with ChangeNotifier
{

  final _api = MediaApi();

  List<Media> _media = [];
  bool _loadin = true;
  bool _loadinMore = false;
  String? _selectedMedia;
  String? _thumbnail;
  String? _fileType;
  int _page = 1;


  List<Media> get media =>_media;
  String? get thumbnail => _thumbnail;
  bool get loading =>_loadin;
  bool get loadMore =>_loadinMore;
  String? get selectedMedia => _selectedMedia;
  String? get fileType => _fileType;


  upDate()=>notifyListeners();

  setFileTYpe(String? type) async
  {
    _fileType = type;
    notifyListeners();

  }



  addImage(BuildContext context) async
  {
    _fileType = 'PHOTO';
    await addMedia(context);
  }

  addVideo(BuildContext context) async
  {
    _fileType = 'VIDEO';
    RouteTo(context, child: (p0, p1) => VideoScreen(clean: true,),);
  }


  clearMedia()
  {
    _selectedMedia = null;
    _thumbnail = null;
  }

  addMedia(BuildContext context) async
  {
    if(_fileType=='PHOTO')
      {
        await selectMediaImage(context);
        if(_selectedMedia!=null)
          {
            await OpenDailovgWithAnimation(context,
                barriarDissmesible: false,dailog: WillPopScope(
                  onWillPop: ()async{
                    return false;
                  },
                  child: AlertDialog(
                                title: Text("Upload Image"),
                                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(aspectRatio: 1,
                      child: SizedBox(
                        child: Image.file(File(_selectedMedia??'',),fit: BoxFit.cover,),
                      ),),
                    SizedBox(height: SC.from_width(20),),

                    Row(children: [
                      Expanded(
                        child: MyactionButton(
                            lable: 'Upload',
                            action: ()async{
                              await _uploadMedia(context);
                        }),
                      ),
                      SizedBox(width: SC.from_width(10),),
                      Expanded(
                        child: MyactionButton(
                            inversTheme: true,
                            color: Colors.red,
                            lable: 'Cancel',
                            action: (){
                              _selectedMedia = null;
                              Navigator.pop(context);
                            }),
                      )
                    ],)
                  ],
                                ),
                              ),
                ));
          }


      }
    else if(_fileType=='VIDEO')
    {

      if(_thumbnail==null||_selectedMedia==null)
        {
          return showSnakeBar(context,
              color: Colors.red,
              message: "Provide Media and Thumbnail For Media");
        }

       await _uploadMedia(context);
      _selectedMedia = null;
      _thumbnail  = null;

    }
    else if(_fileType==null)
      {
        showSnakeBar(context, message: "Select Media Type");
      }
  }


  selectMediaImage(BuildContext context)async
  {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery,);
    if(result!=null)
    {
      _selectedMedia = result.path;
      notifyListeners();
    }
  }

  selectThumbnailImage(BuildContext context)async
  {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery,);
    if(result!=null)
    {
      _thumbnail = result.path;
      notifyListeners();
    }
  }

  selectMediaVideo(BuildContext context)async
  {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false
    );
    if(result!=null&&result.files.isNotEmpty)
      {
        _selectedMedia = result.files[0].path;
        notifyListeners();
      }
  }


  clearFields()
  {
    _selectedMedia = null;
    _fileType = null;
  }


  //
  _uploadMedia(BuildContext context) async
  {
    if(_selectedMedia ==null||_fileType==null)
    {
      showSnakeBar(context, message: "Provide All Details Of Your Post",color: Colors.red);
      return ;
    }

    if(_fileType=='VIDEO'&&_thumbnail==null)
      {
        return ;
      }

    var resp = await _api.addMedia(

        businessId: Provider.of<CurruntBusinessProvider>(context,listen: false).curruntBusiness?.id??'',
        googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
      mediaType: _fileType??'',
      mediaUrl: _selectedMedia??'',
      thumb: _thumbnail
    );



    switch(resp.statusCode)
    {
      case 201:
        var d = jsonDecode( await resp.body);
        var p = Media.fromJson(d['data']);
        _media.add(p);
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
  requestDelete(BuildContext context,Media media) async
  {

    bool? p = await OpenDailovgWithAnimation(context, dailog: AlertDialog(

      title: Text("Delete This Media"),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          MyactionButton(
            color: Colors.red,
            action: ()async{
              await _deleteMedia(context, media);
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
  _deleteMedia(BuildContext context,Media p) async
  {
    var resp = await _api.deletePost(
      gbmPostId: p.gmbMediaId??'',
      googleToken: Provider.of<AuthProvider>(context,listen: false).googleToken??'',
      businessId: p.businessId??'',
    );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode( await resp.body);
        _media.removeWhere((element) => p.id==element.id,);
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
    _media = [];
    _loadin = true;

    BusinessModel? b =  await DB().getBusiness();
    var resp = await _api.getAllMedia(businessId:b?.id??'' );

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        List data = d['data'];
        _media = data.map((e) => Media.fromJson(e),).toList();
        if(_media.isNotEmpty)
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