import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_Cubit.dart';
import 'package:shop_food_app/bloc/Shop_State.dart';
import 'package:shop_food_app/component/cons.dart';
import 'package:shop_food_app/screen/add_screen.dart';
import 'package:shop_food_app/screen/cart_screen.dart';
import 'package:shop_food_app/screen/description_screen.dart';

import '../models/food_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
  listener: (context, state) {},
  builder: (context, state) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Food "),
        actions: [

              ShopCubit
                  .get(context)
                  .userModel!
                  .isAdmin == true ?
              IconButton(onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return AddScreen();
                    }));
              }, icon: const Icon(Icons.add, color: Colors.white,)) :
              IconButton(onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return CartScreen(index: ShopCubit
                          .get(context)
                          .cartList
                          .length,);
                    }));
              },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: const Icon(Icons.shopping_cart, color: Colors.white,)),

          if( ShopCubit.get(context).userModel!.isAdmin == false)
          Text("${ShopCubit.get(context).cartList.length}",style: TextStyle(fontSize: 18),),

              IconButton(onPressed: () {
                logOut(context);
              }, icon: const Icon(Icons.logout)),

        ],
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              margin: const EdgeInsets.all(8),
              child:
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: const [
                  Image(
                    image: NetworkImage
                      ('https://images.pexels.com/photos/5965986/pexels-photo-5965986.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,


                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(""
                      ,style: TextStyle(color: Colors.white),),
                  ),

                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return buildFoodPost(
                    ShopCubit.get(context).postsModel[index],context , index
                );
              },
              itemCount: ShopCubit.get(context).postsModel.length,
            ),
          ],

        ),

      ),
    );
  },
);
  }

  Widget buildFoodPost(FoodPostModel model ,BuildContext context,index ) {
    return Card(
                margin: const EdgeInsetsDirectional.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                child:  GridTile(
                    footer: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: 30,
                        decoration: const BoxDecoration(
                           color: Colors.teal,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                        ),
                        child: Row(

                          children: [
                            Text("${model.name}",style: const TextStyle(color: Colors.white,fontSize: 18),),
                            const Spacer(),

                            if(ShopCubit.get(context).userModel!.isAdmin == false)

                              IconButton(onPressed: (){
                             ShopCubit.get(context).addToCart(name: model.name,price: model.price,foodId: model.foodId,
                                 index: index);
                             total=total! + model.price!.toInt();
                             // Navigator.of(context).push(MaterialPageRoute(builder: (context)
                             // {
                             //   return CartScreen(index: index,);
                             // }));
                           },
                               icon:  const Icon(Icons.shopping_cart, color: Colors.white,size: 20,))
                          ],
                        )),
                    header: Row(

                      children: [
                        Text("\$${model.price} ",style: const TextStyle(color: Colors.white,fontSize: 18
                            ,backgroundColor: Colors.teal,fontWeight: FontWeight.bold, ),),

                      ],
                    ),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(15),

                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)
                          {
                            return DescriptionScreen(index: index,);
                          }));
                        },
                        child: Image(
                          image: NetworkImage
                            ('${model.foodPostImage}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ),
              );
  }
}
