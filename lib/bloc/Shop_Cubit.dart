import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_food_app/models/food_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../component/cons.dart';
import '../models/Shop_User_Model.dart';
import 'Shop_State.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(): super(ShopInitialState());

  static ShopCubit get(context)  => BlocProvider.of(context);



  List<FoodPostModel> postsModel = [];
  List<String> postsId = [];

  ShopUserModel? userModel;
  FoodPostModel? foodPostModel;

  Future<void> getUserData() async {
    emit(ShopGetUserLoadingsState());
    await FirebaseFirestore.instance.collection('users')
        .doc(uid).get()
        .then((value) {
      // uid=value['users']['uid'];

      print(value.data());
      print("uid >>>>>>>> ${uid.toString()}");
      userModel = ShopUserModel.fromJson(value.data()!);
      emit(ShopGetUserSuccessState());
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }






  File? foodPostImage ;
  var picker =ImagePicker();

  Future<void> getFoodPostImage()async{
    final pickedFile=await picker.getImage
      (source: ImageSource.gallery);

    if(pickedFile != null){
      foodPostImage=File(pickedFile.path);
      emit(ShopPostImagePickedSuccessState());
    }else{
      print("No image selected");
      emit(ShopPostImagePickedErrorState());
    }

  }

  void removeFoodPostImage(){
    foodPostImage = null;
    emit(ShopRemovePostImageState());
  }

  void uploadPostImage({

     String? dateTime,
    required String text,
    required String name,
    required int price,
     String? foodId,

  }){
    emit(ShopCreatePostLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref().
    child('posts/${Uri.file
      (foodPostImage!.path)
        .pathSegments.last}').putFile(foodPostImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
//        emit(ShopUploadCoverImageSuccessState());
        print(value);
        createFoodPost(
            text: text,
            dateTime: dateTime!,
            foodPostImage: value,
          name: name,
          price: price,
          foodId: foodId

        );
      }).catchError((error){
        emit(ShopCreatePostErrorState());

      });
    }).catchError((error){
      emit(ShopCreatePostErrorState());

    });
  }

  void uploadUpdatePostImage({

    String? dateTime,
     String? text,
     String? name,
     int? price,
    String? foodId,

  }){
 //   emit(ShopCreatePostLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref().
    child('posts/${Uri.file
      (foodPostImage!.path)
        .pathSegments.last}').putFile(foodPostImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        updateFood(
          foodPostImage: value
        );

      }).catchError((error){
 //       emit(ShopCreatePostErrorState());

      });
    }).catchError((error){
      emit(ShopCreatePostErrorState());

    });
  }


List foodsId=[];
  void createFoodPost({

    required String dateTime,
    required String name,
    required String text,
    required int price,
    String? foodPostImage,
    String? foodId,

  })
 async {
    emit(ShopCreatePostLoadingState());

    FoodPostModel model = FoodPostModel(
        name: name,
        uId: userModel!.uId,
        foodPostImage: foodPostImage??"",
        text: text,
        dateTime: dateTime,
        price: price,
        foodId: foodId
    );


    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('posts');

    final DocumentReference newDocRef = usersCollection.doc();
    await newDocRef.set({
      'foodId': newDocRef.id,
      'name':name,
      'uId':userModel!.uId,
      "foodPostImage": foodPostImage??"",
      'text': text,
      'dateTime': dateTime,
      'price': price,

    });
   model.foodId= newDocRef.id;
    print('id>>>>>>>>${model.foodId}');
    emit(ShopCreatePostSuccessState());
    // usersCollection.
    // add(model.toMap())
    //     .then((value) {
    //
    //        print('id>>>>>>>>${model.foodId}');
    //
    //   emit(ShopCreatePostSuccessState());
    // }).catchError((error){
    //   emit(ShopCreatePostErrorState());
    // });

  }




  void getPosts()
  {

    FirebaseFirestore.instance
        .collection('posts')
        .get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .get()
            .then((value) {
          postsId.add(element.id);
          postsModel.add(FoodPostModel.fromJson(element.data()));

        }).catchError((error){

        });

      });
      emit(ShopGetPostsSuccessState());
    }).catchError((error){
      emit(ShopGetPostsErrorState(error.toString()));
    });

  }

  void updateFood({
     String? name,
     String? text,
    int? price,
     String? foodId,
     String? id,
    String? foodPostImage,
  })
  {
    emit(ShopFoodUpdateLoadingState());

    FoodPostModel model = FoodPostModel(
      name: name,
     price: price,
      text: text,
      foodId: foodId,
      uId: id,
      foodPostImage: foodPostImage



    );
    FirebaseFirestore.instance.collection('posts')
        .doc(foodId).
    update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error){
      emit(ShopFoodUpdateErrorState());
    });

  }


  void deleteFood({required String foodId,required int index})
  {
    emit(ShopFoodDeleteLoadingState());

    postsModel.removeAt(index);

    FirebaseFirestore.instance.collection('posts')
        .doc(foodId).delete()
        .then((value) {

          print(foodId);
    }).catchError((error){
      emit(ShopFoodDeleteErrorState());
    });

  }

  List<FoodPostModel> cartList=[];

  void addToCart({
    String? name,
    int? price,
    String? foodId,
    int? index,
})
  {
    emit(ShopAddToCartLoadingState());

    cartList.add(FoodPostModel(name: name,price: price , foodId: foodId));
   // cartList =[FoodPostModel(name: name,price: price , foodId: foodId,)];
    emit(ShopAddToCartSuccessState());

  }

  void removeCart()
  {
    emit(ShopClearCartLoadingState());

    cartList=[];

    emit(ShopClearCartSuccessState());

  }

  void deleteItemCart({int? index})
  {
    emit(ShopDeleteItemCartLoadingState());

    cartList.removeAt(index!);

    emit(ShopDeleteItemCartSuccessState());

  }
}
