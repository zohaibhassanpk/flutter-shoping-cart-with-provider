import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_cart/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_model.dart';

class CartProvider with ChangeNotifier{
  DbHelper db= DbHelper();

  int _counter=0;
  int get counter => _counter;

  double _totelPrice=0.0;
  double get totelPrice => _totelPrice;
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart =>_cart;
  Future<List<Cart>> getData()async{
    _cart=db.getCartList();
    return _cart;
  }

  void _setPrefItem()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('totel_price', _totelPrice);
    notifyListeners();

  }
  void _getPrefItem()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    _counter=prefs.getInt('cart_item')?? 0;
    _totelPrice=prefs.getDouble('totel_price')??0;

    notifyListeners();

  }
  void addTotelPrice(double productPrice){
    _totelPrice=_totelPrice+productPrice;
    _setPrefItem();
    notifyListeners();
  }
  void  removeTotelPrice( double productPrice){
    _totelPrice=_totelPrice-productPrice;
    _setPrefItem();
    notifyListeners();
  }
  double getTotelPrice(){
    _getPrefItem();
    return _totelPrice;
  }

  void addCounter(){
    _counter++;
    _setPrefItem();
    notifyListeners();
  }
  void  removeCounter(){
    _counter--;
    _setPrefItem();
    notifyListeners();
  }
  int getCounter(){
   _getPrefItem();
    return _counter;
  }




}