import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/BusinessServiceProvider.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AllServiceScreen extends StatefulWidget {
  const AllServiceScreen({super.key});

  @override
  State<AllServiceScreen> createState() => _AllServiceScreenState();
}

class _AllServiceScreenState extends State<AllServiceScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BusinessServiceProvider>(context,listen: false).getAllService(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: Text("Service"),
      ),


      body: Consumer<BusinessServiceProvider>(builder: (context, p, child){

        if(p.loading)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        if(p.service.isEmpty)
          {
            return Center(
              child: NoDataPlaceHolder(),
            );
          }

        return ListView(
          padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 20,
              bottom: SC.from_width(70)
          ),
          children: [

            Ink(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: InkWell(
                onTap: (){
                  p.addService(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: SC.from_width(15)),
                  child: Text("Add Service",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
                ),
              ),
            ),
            SizedBox(height: SC.from_width(10),),

            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),


              itemCount: p.service.length,
              itemBuilder: (context, i) {

                return MyCard(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(0),
                  margin: EdgeInsets.only(
                    bottom: SC.from_width(10)
                  ),
                    child: Row(
                      children: [
                        SizedBox(width: SC.from_width(12),),
                        Expanded(child: Text("${p.service[i].services}",
                          style: AppConstant.richInfoTextLabel(BuildContext).copyWith(fontSize: SC.from_width(14),
                          color:AppConstant.primaryColor),

                        ),
                        ),
                        IconButton(onPressed: (){
                          p.requestDelete(context, p.service[i]);
                        }, icon: Icon(Icons.cancel_outlined,color: Colors.red,))
                      ],
                    ));

              },
            ),
          ],
        );
      },),

    );
  }
}
