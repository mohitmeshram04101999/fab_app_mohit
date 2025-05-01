import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/my_shimmer_widget.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurruntBusinessProvider>
      (builder: (context, p, child) => MyCard(
      margin: EdgeInsets.zero, 
      child: MyShimmerWidget(
        loading: false,
        child: ListTile(


          onTap: kDebugMode?() async{


             await OpenDailovgWithAnimation(context, dailog: Consumer<AuthProvider>(builder: (context, _p, child) => Container(
               margin: EdgeInsets.all(20),
               width: double.infinity,
               height: SC.from_width(300),
               child: Card(
                 child: ListView(
                   padding: EdgeInsets.all(20),
                   children: [

                     SelectableText("userID  :-\n${_p.user?.user?.id}\n${'*'*30}"),
                     SizedBox(height: SC.from_width(20),),

                     SelectableText("userToken  :-\n${_p.user?.user?.token}\n${'*'*30}"),
                     SizedBox(height: SC.from_width(20),),

                     SelectableText("googleToken  :-\n${_p.googleToken}\n${'*'*30}"),
                     SizedBox(height: SC.from_width(20),),

                     SelectableText("email  :-\n${_p.googleAccount?.email}\n${'*'*30}"),
                     SizedBox(height: SC.from_width(20),),

                     SelectableText("subDetail  :-\n${_p.user?.subscription?.toJson()}\n${'*'*30}"),
                     SizedBox(height: SC.from_width(20),),

                   ],
                 ),
               ),
             ),));

          }:null,

          //
          leading: CircleAvatar(

            child: Container(
              clipBehavior: Clip.hardEdge,
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child:Image.network(
                  '${MyUrl.bucketUrl}${p.curruntBusiness?.description}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
              ),
            ),
          ),
          title: Text("${p.curruntBusiness?.name??'Guest'}",maxLines: 1,overflow: TextOverflow.ellipsis),


          subtitle:  Text("${Provider.of<AuthProvider>(context).user?.user?.email??Provider.of<AuthProvider>(context).googleAccount?.email??'Gmail is Not Updated'}",maxLines: 1,overflow: TextOverflow.ellipsis,) ,
        ),
      ),
    ),);
  }
}
