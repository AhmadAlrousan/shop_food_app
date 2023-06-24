import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_Register_State.dart';
import 'package:shop_food_app/screen/shop_login_Screen.dart';
import 'package:shop_food_app/screen/home_screen.dart';

import '../bloc/Shop_Register_cubit.dart';


class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  var fromKey = GlobalKey<FormState>();
  var nameC = TextEditingController();
  var emailC = TextEditingController();
  var phoneC = TextEditingController();
  var passwordC = TextEditingController();

  bool isv = true;
  bool isv2 = false;
  @override
  Widget build(BuildContext context) {
    return    BlocProvider(
  create: (context) => ShopRegisterCubit(),
  child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
  listener: (context, state) {
    if(state is ShopCreateUserSuccessState)
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ShopLoginScreen();
            }));
      }
  },
  builder: (context, state) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: fromKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .37,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Center(
                          child: Text("Register" , style: TextStyle(fontSize: 50 ,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      buildTextFormField(context, "email"),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextFormField(context, "name"),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextFormField(context, "password"),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextFormField(context, "phone"),
                      SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                        // When the button is pressed, the Loading sign appears
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) =>
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(nameC.text);
                                  if (fromKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailC.text,
                                        password: passwordC.text,
                                        name: nameC.text,
                                        phone: phoneC.text
                                    );

                                  }
                                },
                                child: Text("Register"),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.maxFinite, 50),
                                ),
                              ),
                            ),
                        fallback: (context) => CircularProgressIndicator(),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("do have an account? "),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return ShopLoginScreen();
                                    }));
                              },
                              child: Text("Login Now"))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
  Widget buildTextFormField(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: name == "name"
            ? nameC
            : name == "email"
            ? emailC
            : name == "password"
            ? passwordC
            : phoneC,
        decoration: InputDecoration(
            label: Text(name),
            prefixIcon: Icon(name == "password"
                ? Icons.lock
                : name == "name"
                ? Icons.drive_file_rename_outline
                : name == 'email'
                ? Icons.email
                : Icons.phone),
            suffixIcon: name == "password"
                ? IconButton(
              onPressed: () {
                setState(() {
                  isv = !isv;
                });
              },
              icon: Icon(isv ? Icons.visibility : Icons.visibility_off),
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.8),
            )),
        obscureText: name == "password" ? isv : isv2,


        validator: (val) {
          if (val!.isEmpty) {
            return "$name is Empty";
          }
        },
      ),
    );
  }

}
