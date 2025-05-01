import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/ai_providerapi.dart';
import 'package:fab_app/controllers/googleReviewprovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_review_model.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';


class ReplyWithAiScreen extends StatefulWidget {
  final bool edit;
  final Review review;
  const ReplyWithAiScreen({this.edit = false,required this.review,super.key});

  @override
  State<ReplyWithAiScreen> createState() => _ReplyWithAiScreenState();
}

class _ReplyWithAiScreenState extends State<ReplyWithAiScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<AiProvider>(
      
       builder:(context, p, child) => WillPopScope(
         onWillPop: ()async{
           p.clearController();
           return true;
         },

         child: MyScaffold(


          appBar: AppBar(
            title: Text("Reply With Ai"),
          ),


           body: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
             child: Column(



               
               
               children: [


                Expanded(
                  child: MyCard(
                    margin: EdgeInsets.only(bottom: SC.from_width(20)),
                    child: Column(
                      children: [
                        ListTile(
                          minTileHeight: SC.from_width(45),
                          leading: Container(

                            height: SC.from_width(40),
                            width: SC.from_width(40),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: AppConstant.primaryColor,
                                shape: BoxShape.circle
                            ),

                            child: Image.network("${widget.review.reviewImg}",fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(Icons.person,color: Colors.white,),),
                          ),

                          title: Text("${widget.review.reviewerName}",style: AppConstant.font_500_14(BuildContext),),
                          visualDensity: VisualDensity.comfortable,

                          subtitle: Row(
                            children: [
                              StarRating(rating: 2.5,color: AppConstant.primaryColor,size: SC.from_width(15),),
                              SizedBox(width: SC.from_width(5),),

                              Text('${widget.review.rating??0} Stars')
                            ],
                          ),

                        ),

                        Expanded(child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            controller: p.controller,
                            style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: AppConstant.primaryColor),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5)
                            ),

                          ),
                        )),
                        SizedBox(
                          height: SC.from_width(20),
                        )
                      ],
                    ),
                  ),
                ),

                 Row(
                   children: [
                     Expanded(
                         child: MyactionButton(
                           activeOnInit: !widget.edit,
                           inversTheme: true,action: () async{
                             await p.getAiReplySolution(context, widget.review);
                         },lable: 'Ganrate ${p.controller.text.isEmpty?'':'Again'}',)),
                     SizedBox(width: SC.from_width(12),),
                     Expanded(child: MyactionButton(action: () async{
                        await Provider.of<ReviewProvider>(context,listen: false).reply(context, p.controller.text.trim()??'',widget.review);
                     },lable: 'Reply',))
                   ],
                 )

               ],
             ),
           ),

               ),
       ),
    );
  }
}
