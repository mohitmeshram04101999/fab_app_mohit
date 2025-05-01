import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';

class EditCardWidget extends StatefulWidget {
  final String? lable;
  final String? value;
  final TextInputType? keyBord;
  final void Function(String d)? onEditComplete;
  final void Function()? onTap;
  final Widget? trailingIcon;
  final int? maxLine;
  const EditCardWidget({this.maxLine =1,this.trailingIcon,this.onTap,this.keyBord,this.onEditComplete,this.value,this.lable,super.key});

  @override
  State<EditCardWidget> createState() => _EditCardWidgetState();
}

class _EditCardWidgetState extends State<EditCardWidget> {

  bool editMode = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.value??'';
  }


  @override
  void didUpdateWidget(covariant EditCardWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if(oldWidget.value != widget.value)
      {
        controller.text = widget.value??'';
        setState(() {

        });

      }


  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: EdgeInsets.only(top: SC.from_width(14)),
      child: ListTile(

        onTap: widget.onTap,

        contentPadding: EdgeInsets.only(
            left: SC.from_width(16),
            right: SC.from_width(11)
        ),
        title: Text(widget.lable??''),

        titleTextStyle: AppConstant.richInfoTextLabel(BuildContext),
        subtitleTextStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),


        // subtitle: Padding(
        //   padding:EdgeInsets.only(top: SC.from_width(5)),
        //   child: Text('$editMode'),
        // ),

        subtitle: Container(
          // height: SC.from_width(30),
          // color: Colors.red,
          child: TextFormField(
            controller: controller,
            enabled: (editMode&&widget.onTap==null),
            keyboardType: widget.keyBord,
            maxLines: widget.maxLine,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder:InputBorder.none,
              enabledBorder:InputBorder.none,
              disabledBorder:InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 0)
            ),
          ),
        ),

        trailing: Column(
          children: [
            widget.trailingIcon??
                GestureDetector(
              onTap: () async{
                if(editMode)
                  {
                    if(widget.onEditComplete!=null)
                      {
                        widget.onEditComplete!(controller.text);
                      }
                    editMode =false;
                    setState(() {

                    });
                  }
                else
                  {
                    editMode = true;
                    setState(() {

                    });
                  }
              },
              child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(21),),),
          ],
        ),
      ),
    );
  }
}
