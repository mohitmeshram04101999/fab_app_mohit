import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int curruntIndex ;
  final List<BottomNavigationBarItem> items;
  final Function(int) onChange;
  const CustomBottomNavigationBar({required this.onChange,required this.items,this.curruntIndex=0,super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: SC.from_width(50),
      child: Card(
        margin: EdgeInsetsDirectional.zero,
      
      
        
        child: Row(
          children: List.generate(items.length, (index) {
            var selected = curruntIndex==index;

            return Expanded(
              child: InkWell(

                onTap: (){
                  onChange(index);
                },

                child: AnimatedPadding(
                  duration: Duration(milliseconds: 300),
                  padding:
                  EdgeInsets.symmetric(horizontal:selected? 0:0),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if(items[index].icon!=null)
                        (selected)?
                        items[index].activeIcon:
                        items[index].icon,


                      Text("${items[index].label}",
                        style: TextStyle(
                            color: curruntIndex==index?AppConstant.primaryColor:Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            fontSize: SC.from_width(12)
                        ),),
                    ],
                  ),
                ),

              ),
            );

          } ,),
        ),
      
      ),
    );
  }
}
