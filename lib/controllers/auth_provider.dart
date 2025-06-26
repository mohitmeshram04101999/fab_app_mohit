
import 'dart:convert';
import 'dart:developer';

import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/BusinessServiceProvider.dart';
import 'package:fab_app/controllers/compitetor_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/controllers/google_report_detail_provider.dart';
import 'package:fab_app/controllers/homeScreenDetailProvider.dart';
import 'package:fab_app/controllers/porductProvider.dart';
import 'package:fab_app/controllers/postPorovider.dart';

import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/DasnBoard/dash_board.dart';
import 'package:fab_app/screens/auth%20screesn/connect_with_google.dart';
import 'package:fab_app/screens/auth%20screesn/login_in_screen.dart';
import 'package:fab_app/screens/auth%20screesn/otp_screen.dart';
import 'package:fab_app/screens/auth%20screesn/select_business_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthProvider with ChangeNotifier
{

  List<String> _logs = [];
  final AuthApi _authApi = AuthApi();
  final _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'https://www.googleapis.com/auth/business.manage'
      ],
  );
  final _db = DB();


      final TextEditingController _numberContoller = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  User? _user;
  GoogleSignInAccount? _googleUser;
  String? _googleAuthToke;
  List<String> get logs => _logs;


  //edit profile
  String? _changeImage;
  final TextEditingController _nameController= TextEditingController();
  final TextEditingController _phoneController= TextEditingController();
  final TextEditingController _emailController= TextEditingController();


  String? get changeImage => _changeImage;
  String? get googleToken => _googleAuthToke;
  TextEditingController get  nameController =>_nameController;
  TextEditingController get  phoneController =>_phoneController;
  TextEditingController get  emailController =>_emailController;




  TextEditingController get numberController => _numberContoller;
  TextEditingController get otpController => _otpController;
  User? get user=>_user;
  GoogleSignInAccount? get googleAccount => _googleUser;


  addLog(String d){
    _logs.add('${'--'*20}\n$d\n${'--'*20}');
    notifyListeners();
  }

  clearEdit()
  {
    _changeImage =null;
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  editMode()async
  {
    print('user ${_user?.toJson()}');
    _nameController.text = _user?.user?.name??'';
    _phoneController.text = (_user?.user?.mobile??'').toString();
    _emailController.text = _user?.user?.email??'';
  }

  selectProfileImage() async
  {
    var picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(picker !=null)
      {
        _changeImage = picker.path;
        notifyListeners();
      }
  }


  logIn(BuildContext context) async
  {

    var resp  = await _authApi.logIn(_numberContoller.text.trim());

    switch(resp.statusCode)
    {
      case 200:
        RouteTo(context, child: (p0, p1) => OTPScreen(),);
        break;

      case 400:
        showSnakeBar(context,color: Colors.red, message: "${jsonDecode(resp.body)['message']}");
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


  setUser(BuildContext context,User user) async
  {
     await DB().saveUser(user);
     Provider.of<GoogleReportDetailProvider>(context,listen: false).setUser(user);
     Provider.of<KeyWordDetailProvider>(context,listen: false).setUser(user);
     Provider.of<CompetitorDetailProvider>(context,listen: false).setUser(user);
     Provider.of<ProductProvider>(context,listen: false).setUser(user);
     Provider.of<BusinessServiceProvider>(context,listen: false).setUser(user);
     Provider.of<PostProvider>(context,listen: false).setUser(user);

  }


  refreshUser(BuildContext context) async
  {


    await getUser(context, _user?.user?.id??'', _user?.user?.token??'');

  }


  getUser(BuildContext context,String userId,String userToke) async
  {
    var resp = await _authApi.getUser(userId, userToke);


    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        _user = User.fromJson(d['data']);
        _user?.user?.setToken(userToke);
        _googleAuthToke = _user?.accessToken;
         await setUser(context, _user!);
        notifyListeners();
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




  verifyOtp(BuildContext context) async
  {

    var resp  = await _authApi.verifyOTp(_numberContoller.text.trim(),_otpController.text.trim());

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        var _u = UserData.fromJson(d['data']);
        await  getUser(context, _u.id??'', _u.token??'');
        _numberContoller.clear();
        _otpController.clear();

        if(d["isBusiness"]==true)
          {
            BusinessModel b = BusinessModel.fromJson(d['business']);
            await Provider.of<CurruntBusinessProvider>(context,listen: false).setBusiness(context, b);
            ReplaceAll(context, child: (p0, p1) => DashBoard(),);

          }
        else
          {
            ReplaceAll(context, child: (p0, p1) => ConnectWithGoogleScreen(),);
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



  }


  checkUser(BuildContext context) async
  {
    _user = await DB().getUser();
    print('This is user data ${_user?.toJson()}');
    if(_user==null)
      {
        ReplaceTo(context, child: (p0, p1) => LogInScreen(),);
      }
    else
      {

        await getUser(context,_user?.user?.id??'',_user?.user?.token??'');

        print('Now user is set ${_user?.user?.id}');

        var businessProvider = Provider.of<CurruntBusinessProvider>(context,listen: false);
        await businessProvider.getCurruntBusiness(context);

        if(businessProvider.curruntBusiness==null)
        {
          ReplaceTo(context, child: (p0, p1) => SelectAccountScreen(),);

        }

        else
        {
          ReplaceTo(context, child: (p0, p1) => DashBoard(),);

        }


      }
  }



  connectWithGoogle(BuildContext context) async
  {

    addLog("google auth start");
    _googleUser = await _googleSignIn.signIn();
    addLog("the user is $_googleUser");
    if(_googleUser!=null)
    {
      addLog("get user id Not Null");
      var d = await _googleUser?.authHeaders;
      addLog("get header $d");
      _googleAuthToke = d?['Authorization'].toString().split(" ").last;
      addLog("get Token $_googleAuthToke");
      ReplaceTo(context, child: (p0, p1) => SelectAccountScreen(),);
      addLog("Navigate to next Screens");
    }

    addLog("the user is $_googleUser");





    try{


    }catch(e)
    {
      addLog("THis is from catch brock the error is $e");
    }

  }




  logOut(BuildContext context) async
  {

    await DB().clear();
    if(await _googleSignIn.isSignedIn())
      {
        await _googleSignIn.signOut();
      }
    _googleAuthToke = null;
    _googleUser = null;
    _user =null;
    ReplaceAll(context, child: (p0, p1) => LogInScreen(),);

  }


  updateProfile(BuildContext context) async
  {
    var resp =  await _authApi.updateProfile(
        userId: _user?.user?.id??'',
        name: _nameController.text,
        number: _numberContoller.text,
        email: _emailController.text,
      image: _changeImage
    );


    String sString = await resp.stream.bytesToString();

    print('${resp.statusCode}\n${sString}');



    switch(resp.statusCode)
    {
      case 200:
        String token = _user?.user?.token??'';
        var d = jsonDecode(sString);
        _user = User.fromJson(d['data']);
        _user?.user?.setToken(token);
         await setUser(context, _user!);
         notifyListeners();

         clearEdit();
         Navigator.pop(context);
        break;


      case 404:
        showSnakeBar(context, color: Colors.red,message: 'Data Not Found');
        break;

      case 400:
        showSnakeBar(context, color: Colors.red,message: '${jsonDecode(sString)['message']}');
        break;

      case 401:
        tokeExpire(context);
        break;

      case 500:
        serverErrorWidget(context, await resp.stream.bytesToString());
        break;


      default:
        break;
    }


  }


}