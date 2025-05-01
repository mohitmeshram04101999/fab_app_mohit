
import 'dart:convert';

import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:fab_app/models/user_modle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB
{



  Future<void> saveBusiness(BusinessModel business) async
  {
    var db = await SharedPreferences.getInstance();
    db.setString('business', jsonEncode(business.toJson()));
  }


  Future<BusinessModel?> getBusiness() async
  {
    var db = await SharedPreferences.getInstance();

    String? d =  db.getString('business');
    if(d==null)
    {
      return null;
    }
    else
    {
      BusinessModel user = BusinessModel.fromJson(jsonDecode(d));
      return user;
    }
  }

  Future<void> saveUser(User user) async
  {
    var db = await SharedPreferences.getInstance();
    db.setString('user', jsonEncode(user.toJson()));

  }

  Future<Map<String,String>> getRowHeader()async
  {
  var db = await SharedPreferences.getInstance();

  String? d =  db.getString('user');
  if(d==null)
  {
  return {};
  }
  else
  {
  User user = User.fromJson(jsonDecode(d));
  return {
    "Content-Type": "application/json",
    'Authorization':'Bearer ${user.user?.token}'
  };
  }
}


  Future<Map<String,String>> getFormHeader()async
  {
    var db = await SharedPreferences.getInstance();

    String? d =  db.getString('user');
    if(d==null)
    {
      return {};
    }
    else
    {
      User user = User.fromJson(jsonDecode(d));
      return {
        'Authorization':'${user.user?.token??''}'
      };
    }

  }

  Future<User?> getUser() async
  {
    var db = await SharedPreferences.getInstance();

    String? d =  db.getString('user');
    if(d==null)
      {
        return null;
      }
    else
      {
        User user = User.fromJson(jsonDecode(d));
        return user;
      }
  }


  Future<UserData?> clear() async
  {
    var db = await SharedPreferences.getInstance();

     await db.clear();
  }



}