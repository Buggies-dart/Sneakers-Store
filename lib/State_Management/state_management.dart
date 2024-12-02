import 'package:flutter/material.dart';

class ProductsState extends ChangeNotifier {
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> wishList = [];
   
  void addToCart(Map<String, dynamic> sneaker) {
    cart.add(sneaker);
    notifyListeners();
  }

  void addToWishList(Map<String, dynamic> sneaker) {
    wishList.add(sneaker); 
    notifyListeners();
  }

  void removeCart(Map<String, dynamic> sneaker) {
    cart.remove(sneaker);
    notifyListeners();
  }

  void removeWishList(Map<String, dynamic> sneaker) {
    wishList.remove(sneaker); 
    notifyListeners();
  }
  void incrementProductQuantity(int index) {
    cart[index]['quantity']++;
  
    notifyListeners();
  }
  void decrementProductQuantity(int index) {
    if (cart[index]['quantity'] < 2) {
      cart[index]['quantity'];  
    } 
   else{
    cart[index]['quantity']--;
   }
    notifyListeners();
  }

}
