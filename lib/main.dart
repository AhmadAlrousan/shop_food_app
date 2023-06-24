import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/bloc/Shop_Cubit.dart';
import 'package:shop_food_app/screen/home_screen.dart';
import 'package:shop_food_app/screen/shop_login_Screen.dart';
import 'package:shop_food_app/shared/cache_Helper.dart';


import 'Network/MyBlocOserver.dart';
import 'bloc/Shop_State.dart';
import 'component/cons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget? widget;




    Future.delayed(Duration.zero, () async {
      uid = await CacheHelper.getData(key: 'uid') ?? "";
    });

    uid = await CacheHelper.getData(key: 'uid') ?? "";

 // uid="MtUrxTCNgXfMsD9f6N4HjBLMF3I2";// admin


 // uid="ZM8WWJ0xHadwxlRDLaWogzRLWih2"; // user


  print(uid);

  // ignore: unnecessary_null_comparison
  if(uid == null)
  {

   widget = const ShopLoginScreen();
  }else
  {

  widget=HomeScreen ();
  }

  Bloc.observer=MyBlocObserver();

  runApp(MyApp(widget));

}

class MyApp extends StatelessWidget {
  MyApp( this.startWidget);
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getUserData()..getPosts(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
              title: 'Shop Food App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.teal,

              ),
             home: startWidget
           //   home: ShopLoginScreen()

          );
        },
      ),
    );
  }
}

