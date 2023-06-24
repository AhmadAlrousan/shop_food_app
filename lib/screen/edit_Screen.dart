import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Shop_Cubit.dart';
import '../bloc/Shop_State.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key, required this.index});
  int index;
  var nameC = TextEditingController();
  var textC = TextEditingController();
  var priceC = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model=ShopCubit.get(context).postsModel[index];
        var foodImage = ShopCubit.get(context).foodPostImage;

        nameC.text=ShopCubit.get(context).postsModel[index].name!;
        textC.text=ShopCubit.get(context).postsModel[index].text!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Screen'),
            actions: [
              TextButton(onPressed: (){
                ShopCubit.get(context).
                updateFood(
                    name: nameC.text,
                   text: textC.text,
                  price: int.parse(priceC.text),
                  foodId: '${model.foodId}',
              id: '${model.uId}',
              foodPostImage:  '${model.foodPostImage}' ,

                );


                Navigator.pop(context);
              },
                child:  const Text(
                  "Update",
                  style: TextStyle
                    (color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 300,
                    child: GridTile(
                        child: Image(
                          image: NetworkImage('${model.foodPostImage}'),
                          fit: BoxFit.cover,
                        ),
                        footer: Container(
                          alignment: Alignment.bottomRight,

                        )
                    )
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
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: TextFormField(
                       controller: priceC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter Price',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.8),

                            ),
                            prefixIcon: const Icon(Icons.attach_money),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "jh is Empty";
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
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
        );
      },
    );
  }


}
