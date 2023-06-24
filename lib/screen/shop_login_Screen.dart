import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_Cubit.dart';
import 'package:shop_food_app/component/cons.dart';
import 'package:shop_food_app/screen/shop_Register_Screen.dart';

import '../bloc/ShopLoginCubit.dart';
import '../bloc/ShopLoginState.dart';
import '../shared/cache_Helper.dart';
import 'home_screen.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var fromKey = GlobalKey<FormState>();
  var passwordC = TextEditingController();
  var emailC = TextEditingController();
  bool isv = true;
  bool isv2 = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ShopLoginCubit(),
  child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
  listener: (context, state) {
    if(state is ShopLoginSuccessState)
    {
      CacheHelper.saveData(
          key: 'uid',
          value: state.uId.toString()
      )
          .then((value) {
            ShopCubit.get(context).getUserData().whenComplete(() {
              uid=state.uId.toString();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return const HomeScreen();}));
            });
      });


    }

  },
  builder: (context, state) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: fromKey,
        child: Column(children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .4,
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
                  SizedBox(
                    height: 60,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  buildTextFormField(context, "email"),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormField(context, "password"),

                  SizedBox(
                    height: 10,
                  ),


                  ConditionalBuilder(
                    // When the button is pressed, the Loading sign appears
                    condition: state is! ShopLoginLoadingState,
                    builder: (context) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailC.text,
                                    password: passwordC.text);

                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) {
                                  //       return HomeScreen();
                                  //     }));

                              }
                            },
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              fixedSize: Size(double.maxFinite, 50),
                            ),

                          ),
                        ),
                    fallback: (context) => CircularProgressIndicator(),
                  ),                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("dont have an account? "),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ShopRegisterScreen();
                            }));
                          },
                          child: Text("Register Now"))
                    ],
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    ));
  },
),
);
  }

  Widget buildTextFormField(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: name == "password" ? passwordC : emailC,
        decoration: InputDecoration(
            label: Text(name),
            prefixIcon: Icon(name == "password" ? Icons.lock : Icons.email),

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
            )
        ),
        obscureText: name == "password" ? isv : isv2,
        onFieldSubmitted: (value) {
          if (fromKey.currentState!.validate()) {
            ShopLoginCubit.get(context).userLogin(
                email: emailC.text,
                password: passwordC.text);
          }
        },
        validator: (val) {
          // validator Shows some notifications under the TextFormField
          if (val!.isEmpty) {
            // Here, if the TextFormField is empty, it gives an alert
            return "$name is Empty";
          }
        },
      ),
    );
  }
}
