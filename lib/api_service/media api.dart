import 'package:fab_app/api_service/authApi.dart';
import 'package:fab_app/api_service/local_db.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:http/http.dart' as http;



class MediaApi
{


  Future<http.Response> getAllMedia({
    required String businessId,
    int page= 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.getAllMedia(businessId: businessId)}";

    var head = await DB().getFormHeader();

    var resp = await http.get(
      headers: head,
      Uri.parse(uri),
    );



    printResp(uri, resp);

    return resp;
  }


  Future<http.Response> addMedia({
    required String googleToken,
    required String businessId,
    required String mediaType,
    required String mediaUrl,
    String? thumb,
    int page= 1,
  }) async
  {

    String uri = "${MyUrl.base}${MyUrl.createMedia(gToken: googleToken)}";

    var head = await DB().getFormHeader();


    var request = http.MultipartRequest('Post',Uri.parse(uri));

    request.headers.addAll(head);

    request.fields.addAll({
      'mediaFormat':mediaType,
      'businessId':businessId
    });

    request.files.add(await http.MultipartFile.fromPath("mediaUrl", mediaUrl));

    if(thumb!=null)
      {
        request.files.add(await http.MultipartFile.fromPath("thumbnail", thumb));
      }

    var d =  await request.send();

    var r = await d.stream.bytesToString();

    var resp = await http.Response(
        r,d.statusCode
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

    String uri = "${MyUrl.base}${MyUrl.deleteMedia(gbmPostId: gbmPostId,googleToken: googleToken,businessId: businessId)}";

    var head = await DB().getFormHeader();

    var resp = await http.delete(
      headers: head,
      Uri.parse(uri),
    );



    printResp(uri, resp);

    return resp;
  }

}