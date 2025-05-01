import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegularHoureWidget extends StatefulWidget {
  final RegularHour data;
  const RegularHoureWidget({required this.data,super.key});

  @override
  State<RegularHoureWidget> createState() => _RegularHoureWidgetState();
}

class _RegularHoureWidgetState extends State<RegularHoureWidget> {

  @override
  void didUpdateWidget(covariant RegularHoureWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if(oldWidget.data.isOpen!=oldWidget.data.isOpen)
      {
        setState(() {

        });
      }

  }

  final days = {
    '0':'Monday',
    '1':'Tuesday',
    '2':'Wednesday',
    '3':'Thursday',
    '4':'Friday',
    '5':'Sataurday',
    '6':'Sunday',
  };


  var update = false;


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: SC.from_width(11),vertical: SC.from_width(11)),
        margin: EdgeInsets.only(top: SC.from_width(10)),
        color: Colors.white,
        child:Column(
          children: [

            Row(
              children: [
                SizedBox(

                    child: Switch(
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade300,
                        trackOutlineWidth: WidgetStateProperty.resolveWith((states) => 0,),
                        trackOutlineColor: WidgetStateProperty.resolveWith((states) => Colors.transparent,),
                        value:widget.data.isOpen??false,
                        onChanged: (d)async{
                          update = true;
                          setState(() {

                          });
                           await Provider.of<CurruntBusinessProvider>(context,listen: false).updateRegularDay(context, widget.data);
                           update = false;
                        })),

                Text("${days[widget.data.day??'']}",style: AppConstant.richInfoTextLabel(BuildContext),),
                Spacer(),
                if(update)
                  CupertinoActivityIndicator()
              ],
            ),
            SizedBox(height: SC.from_width(10),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${widget.data.openingTime??''}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),),
                Text("To",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500)),
                Text("${widget.data.closingTime??''}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500)),

              ],
            )

          ],
        )
    );
  }
}
