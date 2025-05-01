import 'dart:convert';

import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:http/http.dart' as http;


printResp(String uri,http.Response? resp,{http.StreamedResponse? sResp}) async
{
  if(sResp==null)
    {
      print("$uri\n${resp?.statusCode}\n${resp?.body}");
    }
  else
    {
      print("$uri\n${sResp.statusCode}\n${await sResp.stream.bytesToString()}");
    }
}

class AuthApi
{


  final _dataBase = DB();


  Future<http.Response> getUser(String userId,String token)  async
  {

    String uri = "${MyUrl.base}${MyUrl.getUser}?userId=$userId";

    var resp = await http.get(
        Uri.parse(uri),
      headers: {
          "Content-Type": "application/json",
          'Authorization':'Bearer $token'
      }
    );



    printResp(uri, resp);

    return resp;

  }


  Future<http.Response> getAllPlan({
    int page=1,
})  async
  {

    String uri = "${MyUrl.base}${MyUrl.getPlan}?page=$page";

    var head = await DB().getFormHeader();

    var resp = await http.get(
        Uri.parse(uri),
        headers:head,
    );



    printResp(uri, resp);

    return resp;

  }


  Future<http.Response> getNotification(String userId)  async
  {

    String uri = "${MyUrl.base}${MyUrl.getNotification(userId: userId)}";
    var head = await DB().getFormHeader();

    var resp = await http.get(
        Uri.parse(uri),
        headers:head,
    );



    printResp(uri, resp);

    return resp;

  }


  Future<http.Response> purchasePlan({
    required String? userId,
    required String? planId,
})  async
  {

    String uri = "${MyUrl.base}${MyUrl.purchasePlan}";
    var head = await DB().getRowHeader();

    var d = {
      "userId":userId,
      "planId":planId,
    };

    print(d);

    var resp = await http.post(
      Uri.parse(uri),
      headers:head,
      body: jsonEncode(d),
    );



    printResp(uri, resp);

    return resp;

  }


  Future<http.Response> getNotificationCount(String userId)  async
  {

    String uri = "${MyUrl.base}${MyUrl.getNotificationCount(userId: userId)}";
    var head = await DB().getFormHeader();

    var resp = await http.get(
      Uri.parse(uri),
      headers:head,
    );



    printResp(uri, resp);

    return resp;

  }

  Future<http.Response> getGoogleAuthUrl()  async
  {

    String uri = "${MyUrl.base}${MyUrl.getAuthUrl}";



    var resp = await http.get(
        Uri.parse(uri),);



    printResp(uri, resp);

    return resp;

  }




  //
  Future<http.Response> logIn(String number) async
  {

    String uri = "${MyUrl.base}${MyUrl.login}";

    var resp = await http.post(
        Uri.parse(uri),
        body: {
      'mobile':number,
    });

    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> verifyOTp(String number,String otp) async
  {

    String uri = "${MyUrl.base}${MyUrl.verifyOtp}";

    var resp = await http.post(
        Uri.parse(uri),
        body: {
          'mobile':number,
          'otp':otp,
        });

    printResp(uri, resp);

    return resp;
  }



  Future<http.StreamedResponse> updateProfile({
    String? image,
    required String userId,
    required String name,

    required String number,
    required String email,
})async
  {


    var uri = '${MyUrl.base}${MyUrl.updateProfile}?userId=$userId';

    var d = {
      'name':name,
      'email':email,
    };

    print(d);

    var head = await _dataBase.getFormHeader();

    var request = http.MultipartRequest('PUT', Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll(d);

    if(image!=null)
      {
        request.files.add(await http.MultipartFile.fromPath("userImage", image));
      }

    var resp = await request.send();

    // await printResp(uri, null,sResp: resp);

    return resp;
  }




}