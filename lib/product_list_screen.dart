import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/car_provider.dart';
import 'package:flutter_shopping_cart/cart_model.dart';
import 'package:flutter_shopping_cart/cart_screen.dart';
import 'package:flutter_shopping_cart/db_helper.dart';
import 'package:provider/provider.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DbHelper? dbHelper=DbHelper();
  List<String> productName=['Mango','Orange', 'Banana','Grapes','Cherry','Peach','Mixed Fruit Basket'];
  List<String> productUnit=['KG', 'Dozen','Dozen','KG','KG', 'KG','KG'];
  List<int> productPrice=[10,34,12,13,11,20,18];
  List<String> productImage=[
    'images/pic1.jpg',
    'images/pic2.jpg',
    'images/pic3.jpg',
    'images/pic4.jpg',
    'images/pic5.jpg',
    'images/pic6.jpg',
    'images/pic7.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text('Product List',style: TextStyle(fontWeight: .bold),)),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            },
            child: Center(
              child: Badge(


                backgroundColor: Colors.red,

                label: Consumer<CartProvider>(builder: (context,value,child){
                  return  Text(value.getCounter().toString());
                }),
               child:  Icon(Icons.shopping_bag_outlined),

               ),
              ),
          ),
          SizedBox(width: 18,)



        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index){
            return Card(
              
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      children: [
                        Image(
                            width:100,
                            height: 100,
                            image: AssetImage(productImage[index].toString())),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                          
                            Text(productName[index].toString(), style: TextStyle(fontWeight: .w700,fontSize: 16),),
                            SizedBox(height: 5,),
                            Text(productUnit[index].toString()+' '+ r'$'+productPrice[index].toString()
                                ,style: TextStyle(fontWeight: .w700,fontSize: 16)),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: (){
                                    dbHelper!.insert(
                                      Cart(id: index,
                                          productId: index.toString(),
                                          productName: productName[index].toString(),
                                          productPrice: productPrice[index],
                                          initialPrice: productPrice[index],
                                          productQuantity: 1,
                                          uniTag: productUnit[index].toString(),
                                          image: productImage[index].toString())

                                    ).then((value){
                                      print('product add to cart');
                                      cart.addTotelPrice(double.parse(productPrice[index].toString()));
                                      cart.addCounter();
                                      
                                    }).onError((error,stackTrace){
                                      print(error.toString());
                                    });


                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green

                                    ),
                                    child: Center(child: Text('Add to cart', style: TextStyle(color: Colors.white,fontSize: 15),),),
                                  ),
                                ),
                              )
                          
                          ],),
                        )



                      ],
                    )
                  ],
                ),
              ),
            );
          })),

        ],
      ),

    );
  }
}


