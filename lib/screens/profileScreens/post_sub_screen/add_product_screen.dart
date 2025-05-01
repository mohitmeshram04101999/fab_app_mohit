import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fab_app/api_service/service/MyUrl.dart';
import 'package:fab_app/componenet/CustomTextField.dart';
import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/porductProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddProductScreen extends StatelessWidget {
  final bool editMode;
  final Product? product;
  AddProductScreen({this.product,this.editMode = false});


   final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop:()async{
        Provider.of<ProductProvider>(context,listen: false).clearFields();
        return true;
      },
      child: MyScaffold(


        floatingActionButton: MyactionButton(action: ()async{
            if(editMode&&product!=null)
              {
                await Provider.of<ProductProvider>(context,listen: false).updateProduct(context,product!);
              }
            else
              {
                await Provider.of<ProductProvider>(context,listen: false).createProduct(context);
              }
        },lable: 'Save',),

        //
        appBar: AppBar(
          title: Text("Add Product ${kDebugMode?editMode:''}"),
        ),


        body: Consumer<ProductProvider>(
          builder: (context, p, child) =>  ListView(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 20,
              bottom: SC.from_width(70)
            ),
            children: [

              CustomTextField(
                controller: p.titleController,
                lable: 'Product Title',
                hintText: 'Enter Product Title',
              ),
              SizedBox(height: SC.from_width(20),),


              //
              CustomTextField(
                controller: p.descriptionController,
                contentPed: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                lable: 'Description',
                hintText: 'Enter Description',
                maxLine: 4,
              ),
              SizedBox(height: SC.from_width(20),),

              Text("Attachments",style: AppConstant.richInfoTextLabel(BuildContext) ,),

              MyCard(
                margin: EdgeInsets.only(top: SC.from_width(5)),
                child: MyInkWell(
                  decoration: BoxDecoration(),

                  padding: EdgeInsets.all(SC.from_width(15)),
                  onTap: (){
                    p.selectImage(context);
                  },

                  
                  //
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      child: (p.selectedImage!=null)?
                      Container(
                          width: double.infinity,
                          child: Image.file(File(p.selectedImage??'',),fit: BoxFit.cover,))
                          :(editMode&&product!=null)?
                          Image.network("${product?.media}",
                          errorBuilder: (context, error, stackTrace) => Image.network('${MyUrl.bucketUrl}${product?.media}',
                          fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(30),),
                          ),
                          fit: BoxFit.cover,)
                          :Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/uploadOnClout.png",width: SC.from_width(25),),
                              Text("Upload Image",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey),)
                            ],
                          ),
                        ),
                      )
                  ),

                ),
              )

            ],
          ),

        )

      ),
    );
  }
}
