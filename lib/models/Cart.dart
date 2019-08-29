import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'Product.dart';

class Cart extends ChangeNotifier {
  final List<Product> _products = [];

  UnmodifiableListView<Product> get items => UnmodifiableListView(_products);

  int get countTotalCart => _products.length;
  int get countSelects => _products.where((p)=>p.isSelected == true).length;

  void add(Product product) {
    product.isSelected = false;//limpar a seleçao de exclusão
    _products.add(product);

    notifyListeners();
  }

  void remove(Product product) {
    _products.remove(product);

    notifyListeners();
  }

  void selectedItem(int index){
    _products[index].isSelected = !_products[index].isSelected;

    notifyListeners();
  }

  void selectedItemProduct(Product p){
    p.isSelected = !p.isSelected;

    notifyListeners();
  }

  void removeSelectedItems(){
    _products.removeWhere((p)=>p.isSelected == true);

    notifyListeners();
  }

  double get getTotal{
    double total = 0.0;
    items.forEach((p){
      //total += p.price * p.qtdCart;
    });

    debugPrint("HUDS "+total.toString());

    return total;
  }

  void incrementQtd(int index) {
    //_products[index].qtdCart++;

    notifyListeners();
  }

  void decrementQtd(int index) {

//    if(_products[index].qtdCart > 1)
//      _products[index].qtdCart--;

    notifyListeners();
  }


}
