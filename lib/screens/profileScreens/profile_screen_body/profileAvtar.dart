import 'dart:io';

import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';

class ProfileAvtar extends StatelessWidget {
  final String imageUrl;
  final bool fromeFile;
  final Color editIconBackground;
  final VoidCallback? onEditPressed;

  const ProfileAvtar({
    super.key,
    required this.imageUrl,
    this.fromeFile=false,


    this.editIconBackground = Colors.blue,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: SC.from_width(79),
      height: SC.from_width(79),
      child: Stack(
        clipBehavior: Clip.none,
        children: [



          // Circular profile image with border
          Positioned(
            left: 0,
          right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(1),


              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade50,
              ),
              child: Container(
                // padding: EdgeInsets.all(3), // padding: EdgeInsets.all(3),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
              
                  shape: BoxShape.circle,
                ),
                child:(fromeFile)?
                Image.file(
                  File(imageUrl),
                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      color: Colors.grey,
                    );
                  },
                ) :
                
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
              
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
          ),

          // Edit icon positioned at bottom right
          Positioned(
            bottom: SC.from_width(30),
            right: SC.from_width(-10),
            child: GestureDetector(

              onTap: onEditPressed,
              child: Image.asset(
                "assets/icons/editProfileIcon.png",
                height:SC.from_width(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}