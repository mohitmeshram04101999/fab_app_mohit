import 'dart:convert';

import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/models/get_all_review_model.dart';
import 'package:http/http.dart' as http;


class ReviewApi{


  Future<http.Response>getAllReview({
    required String businessId,
}) async
  {


    var uri = '${MyUrl.base}${MyUrl.getAllReview(businessId: businessId)}';
    var head = await DB().getFormHeader();

    var resp = await http.get(Uri.parse(uri),headers: head);

    printResp(uri, resp);

    return resp;
  }

  Future<http.Response>updateReview({
    required String businessId,
    required String gToken,
    required String reply,
    required Review rev,
  }) async
  {


    var uri = '${MyUrl.base}${MyUrl.upDateReview(businessId: businessId,gToken: gToken)}';
    var head = await DB().getRowHeader();


    var d = {
      'reviewId':rev.reviewId??'',
      'response': reply
    };
    print(d);

    var resp = await http.put(
        Uri.parse(uri),headers: head,
      body: jsonEncode(d),
    );


    printResp(uri, resp);

    return resp;
  }



  Future<http.Response>deleteReviewResponce({
    required String businessId,
    required String gToken,
    required String revId,
  }) async
  {


    var uri = '${MyUrl.base}${MyUrl.deleteReview(businessId: businessId,gToken: gToken,reviewId: revId)}';
    var head = await DB().getFormHeader();

    var resp = await http.delete(
      Uri.parse(uri),headers: head,
    );


    printResp(uri, resp);

    return resp;
  }

}