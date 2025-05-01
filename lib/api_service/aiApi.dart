import 'dart:convert';

import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:http/http.dart' as http;


class AiApi
{

  Future<http.Response> getAiReply({
    required String prompt,
    String? userName,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getAiReply}";

    var head = await DB().getRowHeader();


    var resp = await http.post(
      headers: head,
      Uri.parse(uri),
      body:jsonEncode({
        "prompt":prompt,// "Rudra Jewellers Give Discription"
        "cutomerName":userName??'',
      })

    );



    printResp(uri, resp);

    return resp;
  }


}