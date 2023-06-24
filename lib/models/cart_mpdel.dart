class CartModel {
   String? id;
   String? name;
   int? quntity;
   double? price;

  CartModel(
      { this.id,
         this.name,
         this.quntity,
         this.price});

  CartModel.fromJson(Map<String , dynamic> json)
  {

  id = json['id'];
    name=json['name'];
  quntity=json['quntity'];
  price=json['price'];


  }

  Map<String , dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'quntity':quntity,
      'price':price,


    };
  }
}
