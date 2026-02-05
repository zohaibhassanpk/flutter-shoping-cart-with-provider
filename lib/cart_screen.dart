import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/cart_model.dart';
import 'package:flutter_shopping_cart/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_cart/car_provider.dart';

import 'car_provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DbHelper dbHelper=DbHelper();

  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text('My Product ',style: TextStyle(fontWeight: .bold),)),
        actions: [
          Center(
            child: Badge(


              backgroundColor: Colors.red,

              label: Consumer<CartProvider>(builder: (context,value,child){
                return  Text(value.getCounter().toString());
              }),
              child:  Icon(Icons.shopping_bag_outlined),

            ),
          ),
          SizedBox(width: 18,)



        ],
      ),
      body: Column(
        children: [
          FutureBuilder(future: cart.getData(), builder: (context, AsyncSnapshot<List<Cart>> snapshot){
           if(snapshot.hasData){

             return Expanded(child: ListView.builder(
                 itemCount: snapshot.data!.length,
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
                                   image: AssetImage(snapshot.data![index].image.toString())),
                               SizedBox(width: 10,),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: .start,
                                   crossAxisAlignment: .start,
                                   children: [
                                     Row(
                                       mainAxisAlignment: .spaceBetween,

                                       children: [
                                         Text(snapshot.data![index].productName.toString(), style: TextStyle(fontWeight: .w700,fontSize: 16),),
                                         InkWell(
                                             onTap: (){
                                               dbHelper.delete(snapshot.data![index].id!);
                                               cart.removeCounter();
                                               cart.removeTotelPrice(double.parse(snapshot.data![index].productPrice.toString()));


                                             },
                                             child: Icon(Icons.delete_outline))

                                       ],
                                     ),


                                     SizedBox(height: 5,),
                                     Text(snapshot.data![index].uniTag.toString()+' '+ r'$'+snapshot.data![index].productPrice.toString()
                                         ,style: TextStyle(fontWeight: .w700,fontSize: 16)),
                                     Align(
                                       alignment: Alignment.centerRight,
                                       child: InkWell(
                                         onTap: () {

                                         },
                                         child: Container(
                                           height: 35,
                                           width: 100,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(8),
                                               color: Colors.grey

                                           ),
                                           child: Padding(
                                             padding: const EdgeInsets.all(5.0),
                                             child: Row(
                                               mainAxisAlignment: .spaceBetween,
                                               children: [
                                                 InkWell(
                                                     onTap: (){
                                                       int quantity = snapshot.data![index].productQuantity!;
                                                       int price= snapshot.data![index].initialPrice!;
                                                       quantity--;
                                                       int ? newPrice= price*quantity;
                                                       if(quantity>=1){
                                                         dbHelper!.updatequantity(Cart(id: snapshot.data![index].id,
                                                             productId: snapshot.data![index].productId.toString(),
                                                             productName: snapshot.data![index].productName.toString(),
                                                             productPrice: newPrice,
                                                             initialPrice: snapshot.data![index].initialPrice,
                                                             productQuantity: quantity,
                                                             uniTag: snapshot.data![index].uniTag.toString(),
                                                             image: snapshot.data![index].image.toString())).then((value){

                                                           newPrice=0;
                                                           quantity=0;
                                                           cart.removeTotelPrice(double.parse(snapshot.data![index].initialPrice.toString()));


                                                         }).onError((error,stackTrace){
                                                           print(error.toString());

                                                         });

                                                       }



                                                     },
                                                     child: Icon(Icons.remove,color: Colors.white)),
                                                 Text(snapshot.data![index].productQuantity.toString(), style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: .bold),),
                                                 InkWell(
                                                     onTap: (){
                                                       int quantity = snapshot.data![index].productQuantity!;
                                                       int price= snapshot.data![index].initialPrice!;
                                                       quantity++;
                                                       int ? newPrice= price*quantity;

                                                       dbHelper!.updatequantity(Cart(id: snapshot.data![index].id,
                                                           productId: snapshot.data![index].productId.toString(),
                                                           productName: snapshot.data![index].productName.toString(),
                                                           productPrice: newPrice,
                                                           initialPrice: snapshot.data![index].initialPrice,
                                                           productQuantity: quantity,
                                                           uniTag: snapshot.data![index].uniTag.toString(),
                                                           image: snapshot.data![index].image.toString())).then((value){

                                                             newPrice=0;
                                                             quantity=0;
                                                             cart.addTotelPrice(double.parse(snapshot.data![index].initialPrice.toString()));


                                                       }).onError((error,stackTrace){
                                                         print(error.toString());

                                                       });

                                                     },
                                                     child: Icon(Icons.add,color: Colors.white,)),
                                               ],
                                             ),
                                           ),
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
                 }));
           }else{
             Text('');
           }
           return Center( child: CircularProgressIndicator());
          }),
          Consumer<CartProvider>(builder: (context,value,child){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,
              vertical: 15),
              child: Visibility(
                visible:value.getTotelPrice().toStringAsFixed(2)=='0.00'? false:true,
                child: Column(
                  children: [
                    Reusebele(title: "Sub totel", value: r'$'+value.getTotelPrice().toStringAsFixed(2)),

                  ],
                ),
              ),
            );
          })

        ],
      ) ,
    ) ;
  }
}
class Reusebele  extends StatelessWidget {
  final String title, value;
  const Reusebele ({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, ),
      child: Container(

        decoration: BoxDecoration(
        //color: Colors.white,
            border:BoxBorder.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall,),
              Text(value.toString(), style: Theme.of(context).textTheme.titleSmall,),
            ],),
        ),
      ),
    );
  }
}
