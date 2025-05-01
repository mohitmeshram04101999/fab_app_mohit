import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class RatingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final Color cardColor;
  final Color starColor;
  final int starCount;

  const RatingCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.rating = 0.0,
    this.cardColor = Colors.white,
    this.starColor = Colors.amber,
    this.starCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      elevation: 4,
      margin: EdgeInsets.zero,
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: SC.from_width(5)),

            // Subtitle
            Text(
              subtitle,
              style:  AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),
            ),
            SizedBox(height: SC.from_width(10)),

            // Rating Row
            Container(

              child: Row(
                children: [
                  // Rating Text
                  Text(
                    rating.toStringAsFixed(1),
                    style:TextStyle(
                      fontSize: SC.from_width(37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Stars
                  Column(
                    children: [
                      
                      StarRating(
                        color: AppConstant.primaryColor,
                        rating: rating,
                      ),
                      
                      Text("Based on average ratings",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500,fontSize: SC.from_width(12)),)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}