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

  UnmodifiableListView<Product> itemsByCategory(int categoryId){
    return UnmodifiableListView(_products.where((prod)=>prod.categoryId == categoryId));
  }

  UnmodifiableListView<Product> relatedItens(int idProduto, int categoryId){
    return UnmodifiableListView(
        _products.where((prod)=>prod.id != idProduto && prod.categoryId == categoryId)
    );
  }

  UnmodifiableListView<Product> findProductNameByCategory(String nameProduct, int categoryId){
    return UnmodifiableListView(
        _products.where((prod)=>prod.nameProduct.toLowerCase().contains(nameProduct.toLowerCase()) && prod.categoryId == categoryId)
    );
  }

  UnmodifiableListView<Product> findProductNameByName(String nameProduct){
    return UnmodifiableListView(
        _products.where((prod)=>prod.nameProduct.toLowerCase().contains(nameProduct.toLowerCase()))
    );
  }

  List<Product> getProdutos(){
    List<Product> _products;

//    api.getProducts().then((p){
//      //print(p.nameProduct);
//      _products = p;
//    });
    return _products = [
      Product(1, "Buscopan Composto Com 20 Comprimidos", 11.35, 5, "thumb"),
      Product(2, "Miorrelax 3 Ativos 300mg+50mg+35mg Com 30 Comprimidos", 9.90, 3, "thumb"),
      Product(3, "Ibuprofeno 50mg Gotas 30ml Genérico Medley", 8.05, 5, "thumb"),

      Product(4, "Creme Facial Nivea Antissinais Vitamina E 100g", 29.99, 2, "thumb"),
      Product(5, "Sabonete Liquido Asepxia Esfoliante Pele Mista A Oleosa 100ml", 19.99, 4, "thumb"),

      Product(6, "Sabonete Liquido Dove Nutricao Profunda Refil 200ml", 4.69,1,""),


    ];

  }

}