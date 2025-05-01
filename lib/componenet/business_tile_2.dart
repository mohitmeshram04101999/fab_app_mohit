import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_business_responce_modle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessTile2 extends StatefulWidget {
  final BusinessModel business;
  const BusinessTile2({required this.business,super.key});

  @override
  State<BusinessTile2> createState() => _BusinessTile2State();
}

class _BusinessTile2State extends State<BusinessTile2> {
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurruntBusinessProvider>(
       builder: (context, p, child) => AnimatedContainer(
         duration: Duration(milliseconds: 300),
         padding: EdgeInsets.all(8),
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8),
             color: (p.curruntBusiness?.id==widget.business.id)?AppConstant.primaryColor.withOpacity(.2):Colors.white,
             border: Border.all(
               color: AppConstant.primaryColor,

             )
         ),

         child: Card(
           elevation: 0,
           margin: EdgeInsets.zero,
           color: Colors.transparent,
           child: InkWell(
             borderRadius: BorderRadius.circular(8),

             splashColor: AppConstant.primaryColor.withOpacity(.1),

             onTap: () async{

               if(p.curruntBusiness?.id==widget.business.id)
                 {
                   return ;
                 }

               tap = true;
               setState(() {

               });
                 await p.setBusiness(context, widget.business);

                 tap = false;
                 setState(() {

                 });
             },

             child: Row(
               children: [


                 SizedBox(
                   height: SC.from_width(38),
                   width: SC.from_width(38),
                   child: Stack(
                     children: [

                         Image.asset(
                           (widget.business.gmbSyncStatus=='synced')?
                           "assets/auth_image/busineSelectIcon.png"
                              : 'assets/icons/infoSign.png',
                           width: SC.from_width(38),),

                       if(widget.business.gmbSyncStatus=='synced')
                         Center(child: Icon(Icons.check,color: Colors.white,size: SC.from_width(25),))
                     ],
                   ),
                 ),
                 SizedBox(width: 10,),

                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       // Text("12546556585255",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),


                       Text("${widget.business.name??''}",
                         style:AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),
                       ),

                       Text("46 Archana Tower, 1st Floor",
                         style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
                       SizedBox(height: SC.from_width(5),),

                       Text("Reviews: 142",style: AppConstant.richInfoTextLabel(BuildContext),),


                     ],
                   ),

                 ),

                 if(tap)
                   CupertinoActivityIndicator()

               ],
             ),
           ),
         ),
       ),

    );
  }
}
