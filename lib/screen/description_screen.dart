import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_State.dart';
import 'package:shop_food_app/models/food_model.dart';
import 'package:shop_food_app/screen/edit_Screen.dart';

import '../bloc/Shop_Cubit.dart';

class DescriptionScreen extends StatelessWidget {
  DescriptionScreen({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: const Text('Description'),
            actions: [
              if(ShopCubit.get(context).userModel!.isAdmin == true)
                IconButton(onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return EditScreen(index: index,);
                    }));
              }, icon: const Icon(Icons.edit))
            ],
          ),
          body: buildDescription( ShopCubit.get(context).postsModel[index], context,  index),
        );
      },
    );
  }

  Widget buildDescription(FoodPostModel model, context , index) {
    return SingleChildScrollView(
      child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: GridTile(
                  child: Image(
                  image: NetworkImage
                    ('${model.foodPostImage}'),
                  fit: BoxFit.cover,
                ),

                )
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 30,),
                  Text('\$${model.price}',
                    style: const TextStyle(fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),),
                  const SizedBox(width: 80,),
                  Text('${model.name}',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.teal),),

                ],
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal
                  ),
                  child: Text('${model.text}',
                  style: const TextStyle(fontSize: 20,color: Colors.white),),
                ),
              ),
              const SizedBox(height: 90,),
              if(ShopCubit.get(context).userModel!.isAdmin == true)

                IconButton(onPressed: (){
                ShopCubit.get(context).deleteFood(foodId: '${model.foodId}',index: index);
                Navigator.pop(context);
                print('${model.foodId}');
              },
                icon: const Icon(Icons.delete,size: 40,color: Colors.redAccent,),
            ),
              if(ShopCubit.get(context).userModel!.isAdmin == true)

                const Text("Delete",style: TextStyle(fontSize: 25,color: Colors.redAccent,fontWeight: FontWeight.bold),),


            ],
          ),
    );
  }
}
