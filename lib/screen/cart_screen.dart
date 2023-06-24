import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_Cubit.dart';
import 'package:shop_food_app/bloc/Shop_State.dart';

import '../component/cons.dart';
import '../models/food_model.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
  listener: (context, state) {
  },
  builder: (context, state) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              height: 80,
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        borderRadius: const BorderRadius.all(Radius.circular(20)
                        ),
                      ),
                      child: Text(
                        "\$ $total",
                        style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          ShopCubit.get(context).removeCart();
                          total=0;
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'ORDER NOW',
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListView.separated(

                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildCartScreen(ShopCubit.get(context).cartList[index], context,  index);

                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: ShopCubit.get(context).cartList.length)
          ],
        ),
      ),
    );
  },
);
  }

  Widget buildCartScreen(FoodPostModel model, context , index) {
    return SingleChildScrollView(
      child:Column(
        children: [
          Container(

            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            height: 80,
            child: Card(
              color: Colors.teal[300],
              elevation: 5,
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Text(
                      "\$${model.price}",
                      style: const TextStyle(fontSize: 15,color: Colors.teal,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 110,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${model.name}',style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("\$${model.price}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


              ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      IconButton(onPressed: (){
                        ShopCubit.get(context).deleteItemCart(index: index);
                        total=total! - model.price!.toInt();
                      },
                          icon:const Icon(Icons.delete,size: 35,color: Colors.white,) ),
                      const Text("Delete",style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
