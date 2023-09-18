import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Cartprovider with ChangeNotifier{
  int _counter=0;
  int get counter=>_counter;
  int _totalPrice=0;
  int get totalPrice=>_totalPrice;

  void _setprefitems()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('counter', _counter);
    prefs.setInt('totalPrice', _totalPrice); 
    notifyListeners();
  }
  void _getprefitems()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    _counter=prefs.getInt('counter')??0;
    _totalPrice=prefs.getInt('totalPrice')??0;
    notifyListeners();
  }
  void addtotalPrice(int productprice){
    _totalPrice=_totalPrice+productprice;
    _setprefitems();
    notifyListeners();
  }
  void removeTotalprice(int productprice){
    _totalPrice=_totalPrice-productprice;
    _setprefitems();
    notifyListeners();
  }
  int getTotalPrice(){
    _getprefitems();
    return _totalPrice;
  }
  void addcounter(){
    _counter++;
    _setprefitems();
    notifyListeners();
  }
  void removeCounter(){
    _counter--;
    _setprefitems();
    notifyListeners();
  }
  int getCounter(){
    _getprefitems();
    return _counter;
  }
}