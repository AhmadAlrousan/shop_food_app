// https://newsapi.org/v2/everything?q=amman&apikey=971b95859440402ba82b82759ad383cc



import 'package:flutter/material.dart';
import 'package:shop_food_app/bloc/Shop_Cubit.dart';

import '../screen/shop_login_Screen.dart';
import '../shared/cache_Helper.dart';

void logOut(context){
  ShopCubit.get(context).userModel=null;
  CacheHelper.removeData(key:'uid').then((value) {
    if(value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return ShopLoginScreen();}));
    }
  });
}



 String? uid;

int? total=0;

