import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/googleReviewprovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_review_model.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/profile_screen_body/replywithScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';



class RatingCardListTile extends StatelessWidget {
  final Review review;
  final bool self;

  const RatingCardListTile({required this.review,this.self=false,super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: EdgeInsets.zero,
      child:Column(
        children: [

          ListTile(

            contentPadding: EdgeInsets.symmetric(
              horizontal: SC.from_width(17)
            ),

            leading: Container(
              width: SC.from_width(45),
              height: SC.from_width(45),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,

              ),
              child: Container(
                color: Colors.grey.shade200,
                child: Image.network("${review.reviewImg}",
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.person)
                  ,fit: BoxFit.cover,),
              ),
            ),


            title: Text("${review.reviewerName??''}"),
            titleTextStyle: AppConstant.labelStyl(BuildContext),

            subtitle: Row(
              children: [
                
                StarRating(
                  size: SC.from_width(14),
                  rating: review.rating??0,
                  color: AppConstant.primaryColor,
                ),

                //
                Text("${review.rating??0} Stars",
                style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),

                //
                
              ],
            ),

          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: SC.from_width(17)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("${review.comment}",

              style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
            ),
          ),
          SizedBox(height: SC.from_width(10),),

          if(review.response!=null&&review.response.toString().isNotEmpty)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConstant.primaryColor,
                  )
              ),
              margin: EdgeInsets.symmetric(horizontal: SC.from_width(17)),
              padding: EdgeInsets.symmetric(horizontal: SC.from_width(5),vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${review.response}",
                    textAlign: TextAlign.start,
                    style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
                  SizedBox(height: SC.from_width(20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Ink(
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(6),
                            border: Border.all(
                              color: AppConstant.primaryColor,


                            )
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: (){
                            Provider.of<ReviewProvider>(context,listen: false).requestDelete(context, review);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.delete,color: AppConstant.primaryColor,),
                          ),
                        ),
                      ),
                      SizedBox(width: SC.from_width(8),),


                      Ink(
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(6),
                            border: Border.all(
                              color: AppConstant.primaryColor,


                            )
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: (){
                            Provider.of<ReviewProvider>(context,listen: false).editMode(context, review);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Edit",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: AppConstant.primaryColor,fontWeight: FontWeight.w500),),
                          ),
                        ),
                      ),



                    ],
                  )
                ],
              ),
            ),


          if(review.response==null||review.response.toString().isEmpty)
            Padding(
              padding: EdgeInsets.only(
                left: SC.from_width(17),
                right: SC.from_width(17),
                top: SC.from_width(30),
              ),
              child: CustomButton2(
                onTap: (){
                  RouteTo(context, child: (p0, p1) => ReplyWithAiScreen(review: review),);
                },
                blueLabel: true,
                label: 'Reply With AI',
              ),
            ),


          //
          SizedBox(height: SC.from_width(20),),

        ],
      ),
    );
  }
}
