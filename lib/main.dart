import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/car_provider.dart';
import 'package:flutter_shopping_cart/product_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  ChangeNotifierProvider(create: (_)=> CartProvider() ,
    child: Builder(builder: (BuildContext context){
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen()
      );
      },));
  }
}

