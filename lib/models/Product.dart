import 'dart:collection';
import 'dart:math';
import 'package:crud_flutter_dio_provider/shared/custom_dio.dart';
import 'package:crud_flutter_dio_provider/shared/general_api.dart';
import 'package:flutter/foundation.dart';

class ProductModel extends ChangeNotifier{
//  final List<Product> _products = [
//    Product(1, "Buscopan Composto Com 20 Comprimidos", 11.35, 1, "http://www.farmadelivery.com.br/media/catalog/product/cache/1/image/500x/9df78eab33525d08d6e5fb8d27136e95/b/u/buscopan-composto-adulto-20-comprimidos.jpg", false),
//    Product(2, "Miorrelax 3 Ativos 300mg+50mg+35mg Com 30 Comprimidos", 9.90, 1, "https://www.callfarma.com.br/imagens/produtos/miorrelax-30comprimidos.png", false),
//    Product(3, "Ibuprofeno 50mg Gotas 30ml Genérico Medley", 8.05, 1, "https://paguemenos.vteximg.com.br/arquivos/ids/226498-543-543/ibuprofeno-50mg-gotas-30ml-generico-medley-principal.jpg?v=636869232560730000", false),
//
//    Product(4, "Creme Facial Nivea Antissinais Vitamina E 100g", 29.99, 2, "https://www.drogariacatarinense.com.br/BACKOFFICE/Uploads/Produto/Ampliada/0000042360414-63329.jpg", false),
//    Product(5, "Sabonete Liquido Asepxia Esfoliante Pele Mista A Oleosa 100ml", 19.99, 2, "https://www.onofre.com.br/estaticos/imagens/produtos/card/639997.jpg", false),
//
//    Product(6, "Sabonete Liquido Dove Nutricao Profunda Refil 200ml", 4.69, 3, "https://i5-unilever.a8e.net.br/gm/sabonete-liquido-dove-nutricao-profunda-refil-200ml_169071887_7891150053229E.jpg", false),
//
//  ];

  final GeneralApi api;

  List<Product> _products = [];

  ProductModel(this.api) {
    this._products = getProdutos();
//    this._products = api.getProducts().then((p){
//      //print(p.nameProduct);
//      return p;
//    }) as List<Product>;


  }

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

    return _products;
  }

}

class Product {
  int id;
  String nameProduct;
  double price;
  int categoryId;
  String thumbnail;
  bool isSelected = false;

  Product(
      this.id,
        this.nameProduct,
        this.price,
        this.categoryId,
        this.thumbnail);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameProduct = json['nameProduct'];
    price = json['price'];
    categoryId = json['categoryId'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameProduct'] = this.nameProduct;
    data['price'] = this.price;
    data['categoryId'] = this.categoryId;
    data['thumbnail'] = this.thumbnail;
    data['isSelected'] = this.isSelected;
    return data;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode * nameProduct.hashCode;

  //int get hashCode => idProduto;

  @override
  bool operator ==(other) => other is Product && other.id == id;
}


//@immutable
//class Product {
//  final int idProduto;
//  final String nameProduct;
//  final double price;
//  final int categoryId;
//  final String thumbnail;
//  bool isSelected;
//  int qtdCart = 1;
//
//  Product(this.idProduto, this.nameProduct, this.price, this.categoryId, this.thumbnail, this.isSelected);
//
//  @override
//  int get hashCode => super.hashCode ^ idProduto.hashCode * nameProduct.hashCode;
//
//  //int get hashCode => idProduto;
//
//  @override
//  bool operator ==(other) => other is Product && other.idProduto == idProduto;
//}