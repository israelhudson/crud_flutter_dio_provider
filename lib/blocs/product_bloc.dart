import 'dart:collection';
import 'dart:math';
import 'package:crud_flutter_dio_provider/models/Product.dart';
import 'package:crud_flutter_dio_provider/shared/custom_dio.dart';
import 'package:crud_flutter_dio_provider/repositories/general_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ProductBloc extends ChangeNotifier{

  final GeneralApi api;

  List<Product> _products = [];

  ProductBloc(this.api);

  UnmodifiableListView<Product> get items => UnmodifiableListView(_products);

  //get listProducts => api.getProducts();//Retorna todos os dados da API
  get listProducts {
    //_products = api.getProducts() as List<Product>;
    //products.add(Product(0,"",1.0,));

    return api.getProducts();
  }

  Future<void> fetchData() async{

//    api.getProducts().then((prod){
//      for(int i = 0; i < prod.length; i++){
//        _products.add(prod[i]);
//      }
//
//      _products = prod;
//    });

    api.getProducts().then((data) => _products = data);

    //notifyListeners();

  }

  Future<int> saveProduct(Product product){
    return api.createProduct(product.toJson());
  }

  void delete(Product product){
    api.deleteProduct(product);

    listProducts();


    notifyListeners();
  }




}