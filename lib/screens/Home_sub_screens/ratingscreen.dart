import 'package:fab_app/componenet/RatingCardListTile.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/ratingCardwidget.dart';
import 'package:fab_app/componenet/selection_button.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/googleReviewprovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/get_all_review_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RatingScreen extends StatefulWidget {
  final String? type;
  const RatingScreen({this.type,super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type!=null)
      {
        type = widget.type!;
      }
    Provider.of<ReviewProvider>(context,listen: false).getAllReview(context);
  }

  String type= 'All';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      //
      appBar: AppBar(
        title: Text("Ratings"),
      ),


      //
      floatingActionButton: FloatingActionButton(

        onPressed: (){},

        //
      child: SizedBox(
        width: SC.from_width(30),
          child: Image.asset("assets/icons/help.png",width: SC.from_width(45),)),),


      body: Consumer<ReviewProvider>(builder: (context, p, child) {
        if(p.loading)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        if(p.review.isEmpty)
          {
            return Center(
              child: NoDataPlaceHolder(),
            );
          }


        return RefreshIndicator(
          onRefresh: ()async{
             await p.getAllReview(context);
          },
          child: ListView(

            padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12
            ),

            children: [


              //Rating zCard
              RatingCard(
                title: '${p.averageRating?.title??''}',
                subtitle: '${p.averageRating?.description??''}',
                rating: p.averageRating?.averageRating??0,
                cardColor: Colors.white,
                starColor: Colors.amber,
              ),
              SizedBox(height: SC.from_width(21),),


              //Selection Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  SelectionButton(
                    onTap: ()
                      {
                        type='All';
                        p.update();
                      },
                      type2: true,
                      active: type=='All',
                      lable: "All(${p.review.length})"),

                  //
                  SelectionButton(
                      onTap: ()
                      {
                        type='Pending';
                        p.update();
                      },
                      type2: true,
                      active: type=='Pending',
                      lable: "Pending"),

                  //
                  SelectionButton(
                      onTap: ()
                      {
                        type='Replied';
                        p.update();
                      },
                      type2: true,
                      active: type=='Replied',
                      lable: "Replied"),

                ],
              ),



              for(Review r in p.getFilterData(type))
                Padding(
                  padding: EdgeInsets.only(
                      top: 23
                  ),
                  child: RatingCardListTile(
                    review: r,
                  ),
                )


            ],
          ),
        );
      },),
    );
  }
}



