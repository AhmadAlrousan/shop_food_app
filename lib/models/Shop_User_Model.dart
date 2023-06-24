class ShopUserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isAdmin;

  ShopUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isAdmin,

  });

  ShopUserModel.fromJson(Map<String , dynamic> json)
  {

    email = json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    isAdmin=json['isAdmin'];

  }

  Map<String , dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isAdmin':isAdmin,


    };
  }
}