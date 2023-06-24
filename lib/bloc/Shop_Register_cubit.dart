

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/Shop_User_Model.dart';
import 'Shop_Register_State.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context) => BlocProvider.of(context);




  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,


  }) {
    emit((ShopRegisterLoadingState()));
    print(name);

    FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: email, password: password).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          email: email,
          name: name,
          phone: phone,
          isAdmin: false,
          uId: value.user!.uid);

    } ).catchError((error){

      print("00000 Error 000000");

      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });

  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required bool isAdmin,


  })
  {

    ShopUserModel model = ShopUserModel(
        name: name,
        email: email,
        phone: phone,
      isAdmin: isAdmin,
        uId: uId,

    );

    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap()).then((value) {
      print("IIidid");
      emit(ShopCreateUserSuccessState());
    }).catchError((error){
      emit(ShopCreateUserErrorState(error.toString()));

    });


  }



}


