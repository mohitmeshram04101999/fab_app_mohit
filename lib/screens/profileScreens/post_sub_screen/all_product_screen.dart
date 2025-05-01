import 'package:fab_app/componenet/no_data_place_holder.dart';
import 'package:fab_app/componenet/product_widget.dart';
import 'package:fab_app/componenet/snake_bar/snake_bar.dart';
import 'package:fab_app/controllers/MyScaffold.dart';
import 'package:fab_app/controllers/porductProvider.dart';
import 'package:fab_app/daimention/daimentio%20n.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/actionButton.dart';
import 'package:fab_app/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:fab_app/screens/profileScreens/post_sub_screen/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}


class _AllProductScreenState extends State<AllProductScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context,listen: false).getAllProduct(context);
  }


  @override
  Widget build(BuildContext context) {
    return MyScaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(

        title: Text("Product"),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Consumer<ProductProvider>(

        builder: (context, p, child){
          return MyactionButton(
            action: (){
              if(p.subscription?.planDetails?.productManagement==false||p.subscription?.isPlanExpired==true)
              {
                premiumPopUp(context);
                return;
              }
              RouteTo(context, child: (p0, p1) => AddProductScreen(),);
            },lable: 'Add Product',);
        },

      ),
      
      body: Consumer<ProductProvider>(builder: (context, p, child) {
        
        if(p.loading)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        if(p.product.isEmpty)
          {
            return Center(
              child: NoDataPlaceHolder(),
            );
          }
        
        
        return RefreshIndicator(
          onRefresh: () async{
             await p.getAllProduct(context);
          },
          child: ListView.builder(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 20,
              bottom: SC.from_width(70)
            ),
            itemCount: p.product.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: SC.from_width(8)),
              child: ProductWidget(data: p.product[index]),
            ),
          ),
        );
        
      },),





    );
  }
}
