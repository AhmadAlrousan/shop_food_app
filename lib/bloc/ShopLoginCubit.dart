
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_food_app/component/cons.dart';

import 'ShopLoginState.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit(): super(ShopLoginInitialState());


  static ShopLoginCubit get(context)=>
      BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,

  }){

    emit(ShopLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email:email, password:password).then((value) {
          print('login >>>>> ${value.user!.email}');
          uid='${value.user!.uid}';
          emit(ShopLoginSuccessState('${value.user!.uid}'));

    }).catchError((error){
          emit(ShopLoginErrorState(error.toString()));
    });

  }

}


