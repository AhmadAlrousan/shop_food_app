abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopGetUserSuccessState extends ShopStates{}

class ShopGetUserLoadingsState extends ShopStates{}

class ShopGetUserErrorState extends ShopStates{
  final String error;

  ShopGetUserErrorState(this.error);

}








class ShopFoodUpdateLoadingState extends ShopStates{}

class ShopFoodUpdateErrorState extends ShopStates{}

class ShopFoodDeleteLoadingState extends ShopStates{}

class ShopFoodDeleteErrorState extends ShopStates{}

// create post
class ShopCreatePostSuccessState extends ShopStates{}

class ShopCreatePostLoadingState extends ShopStates{}

class ShopCreatePostErrorState extends ShopStates{}

class ShopPostImagePickedSuccessState extends ShopStates{}

class ShopPostImagePickedErrorState extends ShopStates{}

class ShopRemovePostImageState extends ShopStates{}

class ShopGetPostsSuccessState extends ShopStates{}


class ShopGetPostsErrorState extends ShopStates{
  final String error;

  ShopGetPostsErrorState(this.error);

}

class ShopAddToCartSuccessState extends ShopStates{}

class ShopAddToCartLoadingState extends ShopStates{}


class ShopClearCartSuccessState extends ShopStates{}

class ShopClearCartLoadingState extends ShopStates{}

class ShopDeleteItemCartSuccessState extends ShopStates{}

class ShopDeleteItemCartLoadingState extends ShopStates{}