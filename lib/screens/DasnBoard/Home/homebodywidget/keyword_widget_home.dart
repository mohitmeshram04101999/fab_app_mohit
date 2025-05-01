import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/homProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/home_responce_model.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/Home_sub_screens/keyword_report_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeywordWidgetHome extends StatelessWidget {
  KeywordWidgetHome({super.key});

  final data = {
    'It Companies in bhopal': 120,
    'Bhopal it comanies': 89,
    'It Company in bhopal': 55,
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, p, child) {
        if (p.loading) {
          return Text(
            "Loading...",
            style: AppConstant.labelStylTextField(
              BuildContext,
            ).copyWith(color: AppConstant.primaryColor),
          );
        }

         int flex = 3;

        return MyCard(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Keywords",
                  style: AppConstant.labelStylTextField(
                    BuildContext,
                  ).copyWith(color: AppConstant.primaryColor),
                ),
                SizedBox(height: SC.from_width(14)),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: flex,
                      child: Text(
                        'Campaign Name',
                        style: AppConstant.richInfoTextLabel(
                          BuildContext,
                        ).copyWith(fontSize: SC.from_width(14)),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          'Search',
                          style: AppConstant.richInfoTextLabel(BuildContext),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SC.from_width(16)),

                //
                for (Keyword i in p.homeData?.data?.keywords ?? [])
                  Padding(
                    padding: EdgeInsets.only(bottom: SC.from_width(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: flex,
                          child: Text(
                            '${i.name ?? ''}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppConstant.richInfoTextLabel(BuildContext),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              '${i.count}',
                              style: AppConstant.richInfoTextLabel(
                                BuildContext,
                              ).copyWith(color: AppConstant.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: SC.from_width(16)),
                MyactionButton(
                  action: () {
                    RouteTo(
                      context,
                      child: (p0, p1) => KeywordReportDetailScreen(),
                    );
                  },
                  lable: 'View ${p.homeData?.data?.moreKeywords??''} More',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
