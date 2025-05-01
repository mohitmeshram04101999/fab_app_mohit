import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/postPorovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostWidget extends StatelessWidget {
  final Post? post;
  const PostWidget({this.post,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      padding: EdgeInsets.all(SC.from_width(12)),
      margin: EdgeInsets.only(top: 10),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          //
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8)
            ),
            height: SC.from_width(65),
            width: SC.from_width(65),
             child:   Image.network(
                 post?.post??'',
               fit: BoxFit.cover,
               errorBuilder: (context, error, stackTrace) => Image.network(
                 '${MyUrl.bucketUrl}${post?.post}',
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(40),),
               ),
             ),
            
          ),
          SizedBox(width: SC.from_width(10),),


          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //
              Text('${post?.eventTitle??''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppConstant.font_500_14(BuildContext),
              ),

              Text('${post?.eventSummary??''}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstant.richInfoTextLabel(BuildContext),),

            ],
          )),


          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
            [


              InkWell(onTap: (){
                Provider.of<PostProvider>(context,listen: false).editMode(context,post!);
              }, child: Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(20),),
              )),

              SizedBox(height: SC.from_width(4),),
              Padding(
                padding: const EdgeInsets.all(4),
                child: InkWell(onTap: (){
                  Provider.of<PostProvider>(context,listen: false).requestDelete(context,post!);
                }, child: Image.asset("assets/icons/delet.png",width: SC.from_width(25),)),
              )
            ],),
          )


        ],
      ),
    );
  }
}
