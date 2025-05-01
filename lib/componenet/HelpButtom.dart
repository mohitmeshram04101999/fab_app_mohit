import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:flutter/material.dart';



class HelpButtom extends StatelessWidget {
  const HelpButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () async{
      await OpenDailovgWithAnimation(context,
          duration: Duration(milliseconds: 500),
          animation: dailogAnimation.slidUp,
          dailog: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    //
                    Row(
                      children: [
                        Expanded(child: Text('Talk To Customer Support',style: AppConstant.font_500_14(context),)),
                        IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.close))
                      ],
                    ),
                    SizedBox(height: SC.from_width(15),),


                    ListTile(
                      minTileHeight: SC.from_width(53),
                      horizontalTitleGap: 5,
                      tileColor: Colors.white,
                      trailing: Icon(Icons.arrow_forward_ios,size: SC.from_width(15),color: AppConstant.primaryColor,),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      leading: SizedBox(
                        height: SC.from_width(45),
                        width: SC.from_width(45),
                        child:  Image.asset("assets/icons/callIcon.png",
                          fit: BoxFit.cover,
                          color: Color.fromRGBO(16, 192, 62, 1),
                        ),
                      ),

                      title: Text('Call Us',style:  AppConstant.font_500_14(BuildContext).copyWith(color: Colors.black)),
                     subtitle:  Text('Get connect with out customer support.',maxLines: 1,overflow: TextOverflow.ellipsis, style:  AppConstant.richInfoTextLabel2(BuildContext).copyWith(color: Colors.grey.shade500,)),


                    ),
                    SizedBox(height: SC.from_width(10),),


                    ListTile(
                      minTileHeight: SC.from_width(53),
                      horizontalTitleGap: 5,
                      tileColor: Colors.white,
                      trailing: Icon(Icons.arrow_forward_ios,size: SC.from_width(15),color: AppConstant.primaryColor,),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      leading: SizedBox(
                        height: SC.from_width(45),
                        width: SC.from_width(45),
                        child: Image.asset("assets/icons/whatsApp.png",
                          fit: BoxFit.cover,
                         ),
                      ),

                      title: Text('WhatsApp Us',style:  AppConstant.font_500_14(BuildContext).copyWith(color: Colors.black)),
                      subtitle:  Text('Get connected with us via WhatsApp',maxLines: 1,overflow: TextOverflow.ellipsis, style:  AppConstant.richInfoTextLabel2(BuildContext).copyWith(color: Colors.grey.shade500,)),


                    )



                    //


                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    },
      child: Image.asset("assets/icons/help.png",width: SC.from_width(34),),);
  }
}
