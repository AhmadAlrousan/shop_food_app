import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_Cubit.dart';
import 'package:shop_food_app/bloc/Shop_State.dart';

class AddScreen extends StatelessWidget {

  var nameC = TextEditingController();
  var textC = TextEditingController();
  var priceC = TextEditingController();

  AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("add post"),
            actions: [
              TextButton(

                  onPressed: () {
                    if(nameC.text =='' && ShopCubit.get(context).foodPostImage == null && textC.text=='')
                    {
                      null;
                    }
                    else if (ShopCubit.get(context).foodPostImage == null) {
                      null;

                    }
                    else if (nameC.text =='') {
                      null;
                    }
                    else if (textC.text =='') {
                      null;
                    }
                    else{
                      ShopCubit.get(context).uploadPostImage(
                        dateTime: DateTime.now().toString(),
                        text: textC.text,
                        name: nameC.text,
                        price: int.parse(priceC.text),

                      );
                    }
                    ShopCubit.get(context).foodPostImage=null;
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if(ShopCubit.get(context).foodPostImage == null)
                    Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const[
                        Image(
                        image: NetworkImage
                          ('https://images.pexels.com/photos/2105104/pexels-photo-2105104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
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
                  const SizedBox(height: 10,),

                  if(state is ShopCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is ShopCreatePostLoadingState)
                    const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              ShopCubit.get(context).getFoodPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                 Icon(Icons.image),
                                 SizedBox(
                                  width: 5,
                                ),
                                 Text('add photo'),
                              ],
                            )),
                      ),

                    ],
                  ),
                  if(ShopCubit.get(context).foodPostImage == null)

                    const SizedBox(height: 40,),

                  if(ShopCubit.get(context).foodPostImage != null)
                  if(ShopCubit.get(context).foodPostImage != null)
                  Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image:FileImage(ShopCubit.get(context).foodPostImage!),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        IconButton(onPressed: () {
                          ShopCubit.get(context).removeFoodPostImage();
                        },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Icon
                                (Icons.close, size: 20,),

                            ))
                      ],
                    ),
                  const SizedBox(height: 30,),

                  Column(
                    children: [
                       TextFormField(
                        controller: nameC,
                        decoration: InputDecoration(
                          hintText: 'Food Name',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.8),
                            ),
                          prefixIcon: const Icon(Icons.fastfood)

                        ),
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: TextFormField(
                          controller: priceC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Price',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.8),
                              ),
                            prefixIcon: const Icon(Icons.attach_money)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        maxLines: 3,
                        controller: textC,
                        decoration: const InputDecoration(
                          hintText: 'food distribution',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.description),

                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
