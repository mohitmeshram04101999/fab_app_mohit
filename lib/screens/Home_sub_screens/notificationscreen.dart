import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/notification_tile.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/NotificatonProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotificationProvider>(context,listen: false).getNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      appBar: AppBar(
        
        title: Text("Notifications"),
        
      ),


      body: Consumer<NotificationProvider>(
        builder: (context, p, child) {

          if(p.loading)
            {
               return Center(child: CircularProgressIndicator(),);
            }
          if(p.data.isEmpty)
            {
              return Center(
                child: NoDataPlaceHolder(
                  lable: "No Notification",
                ),
              );
            }

          return RefreshIndicator(
             onRefresh: ()async{
                await p.getNotification(context);
             },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                itemCount: p.data.length,
                  itemBuilder: (context, i) => NotificationTile(notification: p.data[i])),
          );

        } ,
      ),

    );
  }
}
