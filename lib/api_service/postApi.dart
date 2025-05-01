import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:http/http.dart' as http;


class PostApi{


  Future<http.Response> getAllPost({
    required String businessId,
    int page= 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getAllPost(businessId: businessId)}";

    var head = await DB().getFormHeader();

    var resp = await http.get(
      headers: head,
      Uri.parse(uri),
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> deletePost({
    required String businessId,
    required String gbmPostId,
    required String googleToken,
    int page= 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.deletePost(gbmPostId: gbmPostId,googleToken: googleToken,businessId: businessId)}";

    var head = await DB().getFormHeader();

    var resp = await http.delete(
      headers: head,
      Uri.parse(uri),
    );



    printResp(uri, resp);

    return resp;
  }



  Future<http.Response> createPost({
    required String googleToken,
    required String businessId,
    required String title,
    required String eventSummary,
    required DateTime startDate,
    required DateTime endDate,
    required String image,
    int page= 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.createPost(gToken: googleToken)}";

    var head = await DB().getFormHeader();


    var request = http.MultipartRequest('Post',Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll({
      'eventTitle':title,
      'eventSummary':eventSummary,
      "startDate":startDate.toIso8601String(),
      'endDate':endDate.toIso8601String(),
      'businessId':businessId
    });
    
    request.files.add(await http.MultipartFile.fromPath("post", image));

    var d =  await request.send();

    var r = await d.stream.bytesToString();

    var resp = await http.Response(
      r,d.statusCode
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> update({
    required String googleToken,
    required String businessId,
    required String title,
    required String eventSummary,
    required DateTime startDate,
    required DateTime endDate,
    required String gbmPostID,
    String? image,
    int page= 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.updatePost(gbmPostId: gbmPostID,businessId: businessId,googleToken: googleToken)}";

    var head = await DB().getFormHeader();


    var request = http.MultipartRequest('PUT',Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll({
      'eventTitle':title,
      'eventSummary':eventSummary,
      "startDate":startDate.toIso8601String(),
      'endDate':endDate.toIso8601String(),
    });

    if(image!=null)
      {
        request.files.add(await http.MultipartFile.fromPath("post", image));
      }

    var d =  await request.send();

    var r = await d.stream.bytesToString();

    var resp = await http.Response(
        r,d.statusCode
    );



    printResp(uri, resp);

    return resp;
  }

}