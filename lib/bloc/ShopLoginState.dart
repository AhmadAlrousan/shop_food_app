
abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
  final String uId;

  ShopLoginSuccessState(this.uId);

}

class ShopLoginErrorState extends ShopLoginState{
  final String error;
  ShopLoginErrorState(this.error);
}



