import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/notification_responce_Model.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final NotificationDataModel notification;
  const NotificationTile({required this.notification,super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: EdgeInsets.only(bottom: SC.from_width(12)),
      child: ListTile(
        selected: notification.seen==false,
        selectedColor: AppConstant.primaryColor,
        leading: IconButton(onPressed: null, icon: Icon(Icons.notifications,color: AppConstant.primaryColor,)),
        title: Text("${notification.title??''}"),
        // titleTextStyle: AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),
        subtitle: Text("${notification.description??''}"),

      ),
    );
  }
}
