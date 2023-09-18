class CartModel {
 late final int?id;
  final String? productId;
  final String? productName;
  final int?initialPrice;
  final int?productPrice;
  final String?productColor;
  final String?image;
  final int?quantity;
  CartModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.productColor,
    required this.image,
    required this.quantity,
  });

  CartModel.fromMap(Map<String,dynamic>res):
  
  id=res['id'],
  productId=res['productId'],
  productName=res['productName'],
  initialPrice=res['initialPrice'],
  productPrice=res['productPrice'],
  productColor=res['productColor'],
  image=res['image'],
  quantity=res['quantity'];

  Map<String,Object?>toMap(){
    return{
      'id':id,
      'productName':productName,
      'productId':productId,
      'initialPrice':initialPrice,
      'productPrice':productPrice,
      'productColor':productColor,
      'image':image,
      'quantity':quantity,
    };
  }
}