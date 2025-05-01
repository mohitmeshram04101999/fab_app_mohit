import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/porductProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductWidget extends StatelessWidget {
  final  Product data;
  const ProductWidget({required this.data,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.only(
          bottom: SC.from_width(10),
        ),
        padding: EdgeInsets.all(SC.from_width(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //
            Container(
              height: SC.from_width(65),
              width: SC.from_width(65),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(8),
              ),

              child:  Image.network("${data.media}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.network("${MyUrl.bucketUrl}${data.media}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(25),),
                ),
                ),
            ),
            SizedBox(width: SC.from_width(18),),

            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text("${data.title}",style: AppConstant.font_500_14(BuildContext),),

                  Text("${data.description}",style: AppConstant.bodyText(BuildContext),),

                ],),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                InkWell(
                  borderRadius: BorderRadius.circular(3),

                  //
                  onTap: (){
                    Provider.of<ProductProvider>(context,listen: false).editMode(context, data);
                  },

                    //
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(20),),
                    )),
                SizedBox(height: SC.from_width(4),),

                InkWell(
                  borderRadius: BorderRadius.circular(3),
                  onTap: (){
                    Provider.of<ProductProvider>(context,listen: false).requestDelete(  context, data);
                }, child: Image.asset("assets/icons/delet.png",width: SC.from_width(30),),)

              ],
            )


          ],)
    );
  }
}
