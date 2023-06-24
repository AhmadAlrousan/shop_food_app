
abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLoadingState extends ShopRegisterState{}


class ShopRegisterErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopCreateUserSuccessState extends ShopRegisterState{}

class ShopCreateUserErrorState extends ShopRegisterState{
  final String error;
  ShopCreateUserErrorState(this.error);
}





