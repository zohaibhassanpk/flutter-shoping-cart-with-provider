class Cart{
  late  final int ? id;
  final String ?productId;
  final String ?productName;
  final int  ? initialPrice;
  final int  ?productPrice;
  final int ?productQuantity;
  final String ?uniTag;
  final String ? image;
  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.initialPrice,
    required this.productQuantity,
    required this.uniTag,
    required this.image


});
  Cart.fromMap(Map<dynamic, dynamic> res )
  :id =res['id'],
  productId = res['productId'],
  productName= res['productName'],
  productPrice=res['productPrice'],
  initialPrice=res['initialPrice'],
  productQuantity=res['productQuantity'],
  uniTag=res['uniTag'],
  image=res['image'];
  Map<String, Object?> toMap(){
    return {
      'id': id,
      'productId' :productId,
      'productName':productName,
      'productPrice':productPrice,
      'initialPrice':initialPrice,
      'productQuantity':productQuantity,
      'uniTag':uniTag,
      'image': image



    };
  }
}