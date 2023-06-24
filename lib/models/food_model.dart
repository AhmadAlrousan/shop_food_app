
class FoodPostModel{
  String? name;
  String? uId;
  String? dateTime;
  String? text;
  String? foodPostImage;
  int? price;
  String? foodId;
  FoodPostModel({
    this.name,
    this.uId,
    this.text,
    this.dateTime,
    this.foodPostImage,
    this.price,
    this.foodId
  });

  FoodPostModel.fromJson(Map<String , dynamic> json)
  {

    text = json['text'];
    name=json['name'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    foodPostImage=json['foodPostImage'];
    price=json['price'];
    foodId=json['foodId'];

  }

  Map<String , dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'foodPostImage':foodPostImage,
      'dateTime':dateTime,
      'text':text,
      'price':price,
      'foodId':foodId,

    };
  }


}