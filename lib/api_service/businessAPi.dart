
import 'dart:convert';

import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:http/http.dart' as http;


class BusinessApis
{

  Future<http.Response> getAllBusiness({
    String? googleToken,
    String? userId,
    String? gmail,
}) async
  {

    String uri = "${MyUrl.base}${MyUrl.getAllBusiness}";

    var data = {
      "accessToken":googleToken,
      'userId':userId,
      'email':gmail,
    };

    var f = {

    };

    data.forEach((key, value) {
      if(value!=null)
        {
          f[key]= value;
        }
    },);


    var resp = await http.post(
      Uri.parse(uri),
      body: f,
    );



    printResp(uri, resp);

    return resp;
  }

  Future<http.Response> getCompany() async
  {

    String uri = "${MyUrl.base}${MyUrl.getCompany}";

    var head = await DB().getFormHeader();


    var resp = await http.get(
        Uri.parse(uri),
      headers: head
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> getBusinessById({
    required String businessId,
    int page = 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getBusinessById(businessId: businessId)}";



    var resp = await http.get(
        Uri.parse(uri),
    );



    printResp(uri, resp);

    return resp;
  }

  Future<http.Response> getAllProduct({
    required String businessId,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getAllProduct(businessId: businessId)}";

    var head = await DB().getFormHeader();

    var resp = await http.get(
      headers: head,
      Uri.parse(uri),
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> getDashBoard({

    String? googleToken,
    required String businessId,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getHomeScreenData}$businessId${(googleToken!=null)?'&accessToken=$googleToken':''}";
    var head  = await DB().getFormHeader();



    var resp = await http.get(
        Uri.parse(uri),
      headers: head
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response>addProduct({
    required String title,
    required String description,
    required String image,
    required String businessId,
  }) async
  {


    String uri = "${MyUrl.base}${MyUrl.createProduct}";
    var head  = await DB().getFormHeader();
    
    
    var request = http.MultipartRequest("Post", Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll({
      'title':title,
      'description':description,
      "businessId":businessId,
    });
    
    request.files.add(await http.MultipartFile.fromPath("media", image));

    var resp  = await  request.send();

    String r = await resp.stream.bytesToString();

    print('${resp.statusCode}  $uri \n $r');

    return http.Response(r, resp.statusCode);
  }


  Future<http.Response>update({
    required String title,
    required String description,
    String? image,
    required String gmbProductId,
  }) async
  {


    String uri = "${MyUrl.base}${MyUrl.updateProduct(gmbProductId: gmbProductId)}";
    var head  = await DB().getFormHeader();


    var request = http.MultipartRequest("PUT", Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll({
      'title':title,
      'description':description,
    });

    if(image!=null)
      {
        request.files.add(await http.MultipartFile.fromPath("media", image));
      }

    var resp  = await  request.send();

    String r = await resp.stream.bytesToString();

    var nresp = http.Response(r, resp.statusCode);

    printResp(uri, nresp);
    return nresp;
  }


  Future<http.Response> deleteProduct({
    required String gmbProductId,

  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.deleteProduct(gmbProductId: gmbProductId)}";
    var head  = await DB().getFormHeader();



    var resp = await http.delete(
      Uri.parse(uri),
      headers: head,
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> deleteKeyForSeo({
    required String keyWordId,
    required String businessId,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.deleteKeyForSeo(keyId: keyWordId,businessId: businessId)}";
    var head  = await DB().getFormHeader();



    var resp = await http.delete(
      Uri.parse(uri),
      headers: head,
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> deleteAdditionalCategory({
    required String catId,
    required String businessId,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.deleteAdditionalCategory(catId: catId,businessId: businessId)}";
    var head  = await DB().getFormHeader();



    var resp = await http.delete(
      Uri.parse(uri),
      headers: head,
    );



    printResp(uri, resp);

    return resp;
  }



  Future<http.Response> getKeyWordDetail({
    required String businessId,
    int page = 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.moreKeyWords(businessId: businessId)}";
    var head  = await DB().getFormHeader();



    var resp = await http.get(
      Uri.parse(uri),
      headers: head
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> getCompetitorDetail({
    int page = 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getMoreCompetitor}";
    var head  = await DB().getFormHeader();



    var resp = await http.get(
      Uri.parse(uri),
      headers: head
    );



    printResp(uri, resp);

    return resp;
  }



  Future<http.Response> getGoogleReportDetail({
    required String businessId,
    int page = 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getGoogleReport(businessId: businessId)}";
    var head  = await DB().getFormHeader();



    var resp = await http.get(
      Uri.parse(uri),
      headers: head
    );



    printResp(uri, resp);

    return resp;
  }


  updateBusiness({
    required String businessId,
    required String googleToken,
    String? primaryPhone,
    String? primaryCategory,
    String? address,
    String? website,
    DateTime? openingDate,
    List<AdditionalCategory>? additionalCategory,
    List<KeyWordForSeo>? keyWordForSeo,
    List<RegularHour>? regularHour,

}) async
  {

    String uri = '${MyUrl.base}${MyUrl.editBusiness(businessId: businessId, googleToken: googleToken)}';
    var head = await DB().getFormHeader();

    var data = {
      'primaryPhone':primaryPhone,
      'openingDate':openingDate?.toIso8601String(),
      'primaryCategory':primaryCategory,
      'address':address,
      'website':website,
      'additionalCategory':additionalCategory==null?null:jsonEncode(List<dynamic>.from(additionalCategory.map((e) => {'category':e.category},))),
      'primaryKeywordForSEO':keyWordForSeo==null?null:jsonEncode(List<dynamic>.from(keyWordForSeo.map((e) => {'keyword':e.keyword},))),
      'regularHours':regularHour==null?null:jsonEncode(List<dynamic>.from(regularHour.map((e) => {
        'day':e.day,
        'openingTime':e.openingTime,
        'closingTime':e.closingTime,
        'isOpen':e.isOpen,
      },))),
    };

    Map<String,String> filterData = {};




    data.forEach((key, value) {
      if(value!=null)
        {
          filterData[key]=value.toString();
        }
    },);

    print("fiter Data = $filterData");



    var request = http.MultipartRequest('PUT',Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll(filterData);
    var d = await request.send();
    var r = await d.stream.bytesToString();

    var resp = http.Response(r, d.statusCode);
    printResp(uri, resp);

    return resp;
  }

}