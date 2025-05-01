import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/Home_sub_screens/ratingscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetureInfoGridView extends StatelessWidget {
  FetureInfoGridView({super.key});

  final data = [
    //
    {
      'title': 'Reply Pending',
      'subTitle': '27 / 50',
      'icon': 'assets/hoem/Fab (16) 1.png',
    },
    //
    //
    {
      'title': 'Reviews (Lifetime)',
      'subTitle': '142',
      'icon': 'assets/hoem/Star 1 (1).png',
    },

    //
    {
      'title': 'Views (Last 30 days)',
      'subTitle': '1500',
      'icon': 'assets/hoem/Fab (18) 1.png',
    },

    //
    {
      'title': 'Engagement  ',
      'subTitle': '142',
      'icon': 'assets/hoem/Fab (17) 1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyCard(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10),

      //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //
          Consumer<HomeProvider>(
            builder: (context, p, child) => GridView(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: SC.from_width(6),
                mainAxisSpacing: SC.from_width(6),
                mainAxisExtent: SC.from_width(63),
              ),

              children: [


                //
                gridItem(

                  onTap: (){
                    RouteTo(context, child: (p0, p1) => RatingScreen(type: 'Pending',),);
                  },
                    title: "Reply Pending",
                    subtitle: '${p.loading?'---':p.homeData?.data?.replyPending??0}',
                    icon: Image.asset('${data[0]['icon']}'),
                ),

                gridItem(
                  onTap: (){
                    RouteTo(context, child: (p0, p1) => RatingScreen(),);
                  },
                  title: "${data[1]['title']}",
                  subtitle: '${p.loading?'---':p.homeData?.data?.reviewMetrics?.googleReviews??0}',
                  icon: Image.asset('${data[1]['icon']}'),
                ),

                gridItem(
                  title: "${data[2]['title']}",
                  subtitle: '${p.loading?'---':p.homeData?.data?.view??0}',
                  icon: Image.asset('${data[2]['icon']}'),
                ),


                gridItem(
                  title: "${data[3]['title']}",
                  subtitle: '${p.loading?'---':p.homeData?.data?.engagement??0}',
                  icon: Image.asset('${data[3]['icon']}'),
                ),

                //

              ],
            ),
          ),
          
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Short on Time? Use our AI Feature',style: AppConstant.bodyText(BuildContext),),
          ),


          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton2(

              onTap: (){
                RouteTo(context, child:(p0, p1) => RatingScreen(), );
              },


              label: 'Reply With AI',),
          ),
          
          //
          SizedBox(height: SC.from_width(17),)

          //

        ],
      ),
    );




  }

  Widget gridItem({
    required String title,
    required String subtitle,
    required Widget icon,
    void Function()? onTap
})
  {
    return Ink(
      decoration: AppConstant.customButtonDecoration(),

      //
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.grey.shade100,
        onTap: onTap,
        child: Center(
          child: ListTile(
            minTileHeight: SC.from_width(10),
            contentPadding: EdgeInsets.symmetric(horizontal: SC.from_width(10),),

            titleTextStyle: AppConstant.bodyText(BuildContext).copyWith(fontWeight: FontWeight.w600),
            subtitleTextStyle: AppConstant.bodyText(BuildContext),

            title: Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,),
            subtitle: Row(
              children: [
                SizedBox(
                  child: icon,
                  width: SC.from_width(21),
                ),
                SizedBox(width: SC.from_width(5)),
                Text(subtitle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
