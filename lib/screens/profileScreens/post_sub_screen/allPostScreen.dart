import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/postWIdget.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/postPorovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add%20event%20Screen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add_product_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ALlPostScreen extends StatefulWidget {
  const ALlPostScreen({super.key});

  @override
  State<ALlPostScreen> createState() => _ALlPostScreenState();
}

class _ALlPostScreenState extends State<ALlPostScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PostProvider>(context,listen: false).getAllPost(context);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(


      onWillPop: ()async{
        return true;
      },

      child: MyScaffold(

        backgroundColor: Colors.grey.shade100,

        appBar: AppBar(
          title: Text("Posts${(kDebugMode)?'  ${Provider.of<AuthProvider>(context,listen: false).user?.subscription?.planDetails?.addEvent}':''}"),
        ),

        floatingActionButton: Consumer<PostProvider>(builder: (context, value, child) => MyactionButton(
          borderRadius: BorderRadius.circular(8),
          action: (){
            if(value.sub?.planDetails?.addEvent==false||value.sub?.isPlanExpired==true)
            {
              premiumPopUp(context);
              return;
            }
            RouteTo(context, child: (p0, p1) => AddEventScreen(),);
          },lable: 'Add Events +',),),


        body: Consumer<PostProvider>(
          builder: (context, p, child) {

            if(p.loading)
              {
                return Center(child:
                CircularProgressIndicator(),
                );
              }

            if(p.post.isEmpty)
              {
                return Center(child: NoDataPlaceHolder(),);
              }

            return RefreshIndicator(
              onRefresh: ()async{
                await  p.getAllPost(context);
              },
              child: ListView.builder(
                padding: EdgeInsets.only(left: 12,right:12 ,bottom: SC.from_width(70),top: 12),
                itemCount: p.post.length,
                itemBuilder: (context, index) => PostWidget(
                  post: p.post[index],
                ),),
            );

          },
        ),


      ),
    );
  }
}
