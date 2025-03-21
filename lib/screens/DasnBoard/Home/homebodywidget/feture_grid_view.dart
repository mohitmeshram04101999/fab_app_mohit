import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';

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
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10),

      //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //
          GridView(
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

            children: List.generate(
              data.length,
              (index) => Container(
                decoration: AppConstant.customButtonDecoration(),

                //
                child: ListTile(

                  contentPadding: EdgeInsets.symmetric(horizontal: SC.from_width(10),),

                  titleTextStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w600),
                  subtitleTextStyle: AppConstant.richInfoTextLabel(BuildContext),

                  title: Text("${data[index]['title']}"),
                  subtitle: Row(
                    children: [
                      SizedBox(
                        child: Image.asset('${data[index]['icon']}'),
                        width: SC.from_width(21),
                      ),
                      SizedBox(width: SC.from_width(5)),
                      Text('${data[index]['subTitle']}'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Short on Time? Use our AI Feature',style: AppConstant.richInfoTextLabel(BuildContext),),
          ),


          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton2(

              onTap: (){},


              label: 'Reply With AI',
            ),
          ),
          
          //
          SizedBox(height: SC.from_width(17),)

          //

        ],
      ),
    );
  }
}
