import 'dart:developer';

import 'package:fab_app/api_service/customateDateTIme.dart';
import 'package:fab_app/componenet/MyCard.dart';
import 'package:fab_app/componenet/customField.dart';
import 'package:fab_app/componenet/custom_buttton_2.dart';
import 'package:fab_app/componenet/editCardWidget.dart';
import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/postWIdget.dart';
import 'package:fab_app/componenet/primiuam_perches_message_widget.dart';
import 'package:fab_app/componenet/product_widget.dart';
import 'package:fab_app/componenet/redular_houre_widget.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/consgt/constWar.dart';
import 'package:fab_app/controllers/BusinessServiceProvider.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/ai_providerapi.dart';
import 'package:fab_app/controllers/auth_provider.dart';
import 'package:fab_app/controllers/curruntBusinessProvider.dart';
import 'package:fab_app/controllers/mediaProvider.dart';
import 'package:fab_app/controllers/porductProvider.dart';
import 'package:fab_app/controllers/postPorovider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/models/businessDetaiModel.dart';

import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/animated%20dilog.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/Home_sub_screens/ratingscreen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/SelectMedia%20Screen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add%20event%20Screen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add_product_screen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/all%20ServiceScreen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/allPostScreen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/all_product_screen.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/edit_profile_screen.dart';
import 'package:fab_app/screens/profileScreens/profile_screen_body/profileAvtar.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final days = {
    '0':'Monday',
    '1':'Tuesday',
    '2':'Wednesday',
    '3':'Thursday',
    '4':'Friday',
    '5':'Sataurday',
    '6':'Sunday',
  };



   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CurruntBusinessProvider>(context,listen: false).getCurruntBusiness(context);
    Provider.of<AiProvider>(context,listen: false).clearController();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(


      floatingActionButton: kDebugMode?FloatingActionButton(onPressed: (){

      }):null,


      body: Consumer<CurruntBusinessProvider>(

        builder: (context, p, child) {
          return RefreshIndicator(
            onRefresh: ()async{
              await p.getBusinessDetail(context);
              await Provider.of<AuthProvider>(context,listen: false).refreshUser(context);
            },
            child: ListView(

              padding: EdgeInsets.only(left: 13,right: 13,top: 10,bottom: 30),

              children: [

                // lable
                Row(
                  children: [

                    //
                    Text("Listing",
                      style: AppConstant.labelStylTextField(BuildContext).copyWith(color: AppConstant.primaryColor),
                    ),
                    SizedBox(width: SC.from_width(17),),

                    InkWell(
                      onTap: (){
                        RouteTo(context, child: (p0, p1) => RatingScreen(),);
                      },
                      child: Text("Review",
                        style: AppConstant.labelStylTextField(BuildContext).copyWith(fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),


                //profile section
                Consumer<AuthProvider>(builder: (context, _p, child) => MyCard(
                  margin: EdgeInsets.only(top: SC.from_width(10)),
                  child: Column(
                    children: [
                      SizedBox(height: SC.from_width(21),),

                      //

                      SizedBox(
                        height: SC.from_width(17),
                      ),


                      ProfileAvtar(
                        imageUrl: _p.user?.user?.userImage??'',
                        onEditPressed: (){
                          RouteTo(context, child: (p0, p1) => EditProfileScreen(),);
                        },
                      ),

                      SizedBox(
                        height: SC.from_width(17),
                      ),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SC.from_width(14)),
                        child: Text("${_p.user?.user?.name??''}",
                          style: AppConstant.labelStylTextField(BuildContext),),
                      ),
                      //





                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: SC.from_width(14)),
                      //   child: CustomButton2(
                      //     blueLabel: true,
                      //     label: 'Generate with AI',
                      //   ),
                      // ),
                      SizedBox(height: SC.from_width(15),)


                    ],
                  ),
                ),),


                //Mobile number
                EditCardWidget(
                  lable: 'Primary Phone',
                  keyBord: TextInputType.number,
                  value: '${p.detail?.primaryPhone??''}',
                  onEditComplete: (d)
                  {
                    if(d!=p.detail?.primaryPhone)
                    {
                      p.updateBusiness(context,primaryPhone: d);
                    }
                  },
                ),

                //Op Date
                EditCardWidget(
                  lable: 'Opening Date',
                  value: '${MyFormate().formateDateTIme(p.detail!.openingDate)}',
                  onTap: () async{
                     var d = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000));
                     if(d!=null)
                       {
                         p.updateBusiness(context,openDate: d);
                       }
                  },
                  trailingIcon: IconButton(onPressed:null, icon: Icon(Icons.calendar_month,color: AppConstant.primaryColor,)),
                ),

                //primerycATEGORY
                EditCardWidget(
                  lable: 'Primary Category',
                  value: '${p.detail?.primaryCategory??''}',
                  onEditComplete: (d){
                    if(d!=p.detail?.primaryCategory)
                    {
                      p.updateBusiness(context,primaryCategory: d);
                    }
                  },
                ),


                // Additional
                MyCard  (
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(14)),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SC.from_width(15)),
                    child: Column(
                      children: [
                        SizedBox(height: SC.from_width(3),),
                        ListTile(

                          contentPadding: EdgeInsets.only(
                              left: SC.from_width(0),
                              right: SC.from_width(0)
                          ),
                          title: Text("Additional Category"),

                          titleTextStyle: AppConstant.richInfoTextLabel(BuildContext),



                          trailing: Column(
                            children: [
                              GestureDetector(child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(21),),),
                            ],
                          ),
                        ),


                        for(AdditionalCategory c in p.detail?.additionalCategory??[])
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SC.from_width(5)
                            ),
                            child: Ink(
                              width: double.infinity,
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                top: SC.from_width(7),
                                bottom: SC.from_width(8),
                                left: SC.from_width(12),
                                right: SC.from_width(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text("${c.category}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),)),
                                  InkWell(
                                    onTap: (){
                                      p.reqDeleteAdditionalCategory(context, c);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Icon(Icons.close,color: Colors.red,size: SC.from_width(18),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        SizedBox(height: SC.from_width(10),),

                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(4),
                          child: MyactionButton(
                            action: (){p.addAdditionCategory(context);},lable: 'Add Additional Category',),
                        ),

                        SizedBox(height: SC.from_width(15),)

                      ],
                    ),
                  ),
                ),

                //Product
                MyCard  (
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(14)),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SC.from_width(15)),
                    child: Column(
                      children: [
                        SizedBox(height: SC.from_width(8),),
                        Row(
                          children: [
                            Text("Product",style: AppConstant.richInfoTextLabel(BuildContext),),
                          ],
                        ),
                        SizedBox(height: SC.from_width(20),),

                        if(p.detail!.products!.isEmpty)...[
                        ]
                        else...[
                          for(Product i in p.detail?.products??[])
                            ProductWidget(data: i),

                        ],
                        SizedBox(height: SC.from_width(10),),



                        MyactionButton(
                          inversTheme: true,
                          borderRadius: BorderRadius.circular(4),
                          action: (){
                            RouteTo(context, child: (p0, p1) => AllProductScreen(),);
                          },lable: 'View More',),
                        SizedBox(height: SC.from_width(10),),

                        Consumer<ProductProvider>(
                          builder: (context, value, child) => MyactionButton(
                            borderRadius: BorderRadius.circular(4),
                            action: (){
                              if(value.subscription?.planDetails?.productManagement==false||value.subscription?.isPlanExpired==true)
                              {
                                premiumPopUp(context);
                                return;
                              }
                              RouteTo(context, child: (p0, p1) => AddProductScreen(),);
                            },lable: 'Add Product +',),
                        ),

                        SizedBox(height: SC.from_width(15),)

                      ],
                    ),
                  ),
                ),


                //Service
                MyCard  (
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(14)),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SC.from_width(15)),
                    child: Column(
                      children: [
                        SizedBox(height: SC.from_width(3),),
                        ListTile(

                          contentPadding: EdgeInsets.only(
                              left: SC.from_width(0),
                              right: SC.from_width(0)
                          ),
                          title: Text("Service"),

                          titleTextStyle: AppConstant.richInfoTextLabel(BuildContext),



                          trailing: Column(
                            children: [
                              GestureDetector(child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(21),),),
                            ],
                          ),
                        ),

                        if(p.detail!.services!.isEmpty)...[
                          NoDataPlaceHolder()
                        ]
                        else...[
                          for(BusinessService i in p.detail?.services??[])
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              margin: EdgeInsets.only(
                                bottom: SC.from_width(10),
                              ),
                              padding: EdgeInsets.only(

                                left: SC.from_width(12),
                                // right: SC.from_width(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text("${i.services??'No Name'}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),)),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.cancel_outlined,color: Colors.red,))
                                ],
                              ),
                            ),

                        ],
                        SizedBox(height: SC.from_width(10),),

                        MyactionButton(
                          inversTheme: true,
                          action: (){
                            RouteTo(context, child: (p0, p1) => AllServiceScreen(),);
                          },lable: 'View More',),

                        SizedBox(height: SC.from_width(10),),
                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(4),
                          child: MyactionButton(
                            action: (){
                              Provider.of<BusinessServiceProvider>(context,listen: false).addService(context);
                            },lable: 'Add Service',),
                        ),

                        SizedBox(height: SC.from_width(15),)

                      ],
                    ),
                  ),
                ),





                //address
                EditCardWidget(
                  maxLine: null,
                  lable: 'Address',
                  value: '${p.detail?.address}',
                  onEditComplete: (d)
                    {
                      {
                        if(d!=p.detail?.address)
                        {
                          p.updateBusiness(context,address: d);
                        }
                      }
                    }
                ),


                //Regular day
                MyCard(
                  margin:EdgeInsets.only(top: SC.from_width(14)),
                  color: Colors.grey.shade50,

                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SC.from_width(11)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SC.from_width(10),),

                        Text("Regular Hours${(kDebugMode)?p.detail?.regularHours?.length:''}",style: AppConstant.richInfoTextLabel(BuildContext),),

                        for(RegularHour d in p.detail?.regularHours??[])
                          RegularHoureWidget(data: d),

                        SizedBox(height: SC.from_width(26),),

                        MyactionButton(action: (){},lable: 'Save',trailingIcon: Icon(Icons.arrow_forward),),
                        SizedBox(height: SC.from_width(26),),

                      ],),
                  ),

                ),


                //posts
                MyCard(
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Posts",style: AppConstant.richInfoTextLabel(BuildContext),),

                        if(p.detail!.post!.isEmpty)...[
                          Center(child: NoDataPlaceHolder()),
                        ]
                        else...[
                          for(int i =0;i<p.detail!.post!.length;i++)
                            PostWidget(post: p.detail?.post?[i],),
                        ],

                        SizedBox(height: SC.from_width(19),),

                        MyactionButton(
                          inversTheme: true,
                          borderRadius: BorderRadius.circular(8),
                          action: (){
                            RouteTo(context, child: (p0, p1) => ALlPostScreen(),);
                          },lable: 'View More',),
                        SizedBox(height: SC.from_width(9),),


                        Consumer<PostProvider>(builder: (context, value, child) => MyactionButton(
                          borderRadius: BorderRadius.circular(8),
                          action: (){
                            if(value.sub?.planDetails?.addEvent==false||value.sub?.isPlanExpired==true)
                            {
                              premiumPopUp(context);
                              return;
                            }
                            RouteTo(context, child: (p0, p1) => AddEventScreen(),);
                          },lable: 'Add Events +',),),

                      ],
                    ),
                  ),
                ),


                //Media
                MyCard(
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Media",style: AppConstant.richInfoTextLabel(BuildContext),),
                        SizedBox(height: SC.from_width(16),),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for(int i =0;i<p.detail!.media!.length;i++)
                                Container(
                                    clipBehavior: Clip.hardEdge,
                                    margin: EdgeInsets.only(right: 10),
                                    height: SC.from_width(111),
                                    width: SC.from_width(111),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Image.network(
                                      "${p.detail?.media?[i].media}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported,size: SC.from_width(30),),
                                    )),
                            ],
                          ),
                        ),

                        SizedBox(height: SC.from_width(16),),

                        Row(
                          children: [

                            //
                            Expanded(
                              child: MyactionButton(
                                height: SC.from_width(36),
                                borderRadius: BorderRadius.circular(8),
                                action: (){
                                  Provider.of<MediaProvider>(context,listen: false).addVideo(context);
                                },lable: 'Add Video',trailingIcon: Icon(Icons.video_call),),
                            ),

                            SizedBox(width: SC.from_width(30),),


                            Expanded(
                              child: MyactionButton(
                                height: SC.from_width(36),
                                borderRadius: BorderRadius.circular(8),
                                action: (){
                                  Provider.of<MediaProvider>(context,listen: false).addImage(context);
                                },lable: 'Add Image',trailingIcon: Icon(Icons.image),),
                            ),

                          ],
                        ),


                        SizedBox(height: SC.from_width(14),),


                        MyactionButton(
                          inversTheme: true,
                          borderRadius: BorderRadius.circular(8),
                          action: (){
                            RouteTo(context, child: (p0, p1) => SelectMediaScreen(),);
                          },lable: 'View More' ,trailingIcon: Icon(Icons.arrow_forward),),

                      ],
                    ),
                  ),
                ),


                //Website
                EditCardWidget(
                  lable: 'Website',
                  value: '${p.detail?.website??''}',
                  onEditComplete: (d){

                      if(d!=p.detail?.website)
                      {
                        p.updateBusiness(context,website: d);
                      }

                  },
                ),

                //primery KeyWord
                MyCard  (
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(14)),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SC.from_width(15)),
                    child: Column(
                      children: [
                        SizedBox(height: SC.from_width(3),),
                        ListTile(

                          contentPadding: EdgeInsets.only(
                              left: SC.from_width(0),
                              right: SC.from_width(0)
                          ),
                          title: Text("Primary Keword for SEO"),

                          titleTextStyle: AppConstant.richInfoTextLabel(BuildContext),



                          trailing: Column(
                            children: [
                              GestureDetector(child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(21),),),
                            ],
                          ),
                        ),


                        if(p.detail!.primaryKeywordForSeo!.isEmpty)...[
                          NoDataPlaceHolder()
                        ]
                        else...[
                          for(KeyWordForSeo k in p.detail?.primaryKeywordForSeo??[])
                            Padding(
                              padding: EdgeInsets.only(bottom: SC.from_width(8)),
                              child: Ink(
                                width: double.infinity,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: SC.from_width(15),
                                    bottom: SC.from_width(12),
                                    left: SC.from_width(12),
                                    right: SC.from_width(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("${k.keyword}",style: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: AppConstant.primaryColor),)),
                                      InkWell(
                                        onTap: (){
                                          p.reqDeleteKeyWordForSeo(context, k);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(Icons.close,color: Colors.red,size: SC.from_width(18),),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],


                        SizedBox(height: SC.from_width(20),),


                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(4),
                          child: MyactionButton(
                            action: (){
                              p.addKeyWordForSeo(context);
                            },lable: 'Add Key Word',),
                        ),

                        SizedBox(height: SC.from_width(15),)

                      ],
                    ),
                  ),
                ),


                //Ai Reply Solution
                MyCard  (
                  color: Colors.grey.shade50,
                  margin: EdgeInsets.only(top: SC.from_width(14)),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SC.from_width(15)),
                    child: Column(
                      children: [
                        SizedBox(height: SC.from_width(3),),
                        ListTile(

                          contentPadding: EdgeInsets.only(
                              left: SC.from_width(0),
                              right: SC.from_width(0)
                          ),
                          title: Text("AI Reply Solution"),

                          subtitle: Text('These Phrrses will be used while replying to reviews'),


                          titleTextStyle: AppConstant.richInfoTextLabel(BuildContext),
                          subtitleTextStyle: AppConstant.richInfoTextLabel(BuildContext).copyWith(color: Colors.grey.shade500),



                          trailing: Column(
                            children: [
                              GestureDetector(child: Image.asset("assets/icons/editProfileIcon.png",width: SC.from_width(21),),),
                            ],
                          ),
                        ),

                        for(var d in p.curruntBusiness?.aiReplySolution??[])
                          Text("${d}"),



                        SizedBox(
                          height: SC.from_width(15),
                        ),


                        SizedBox(height: SC.from_width(20),),


                        MyactionButton(
                          borderRadius: BorderRadius.circular(4),
                          action: () async {
                          },lable: 'Add',),

                        SizedBox(height: SC.from_width(15),)

                      ],
                    ),
                  ),
                )






              ],
            ),
          );
        },

      ),

    );
  }
}
