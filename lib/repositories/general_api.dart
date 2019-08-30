
import 'package:crud_flutter_dio_provider/models/Product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GeneralApi {

  //instancia do Dio
  Dio dio;

  //Construtor do repositorio
  GeneralApi(this.dio);


  Future<List<Product>> getProducts() async {
    Response response = await dio.get("/product");
    //return (response.data as List).map((product)=> Product.fromJson(product)).toList();
    return (response.data as List).map((product)=> Product.fromJson(product)).toList();
  }

  Future<List<Product>> saveProduct(Product product) async {
    Response response = await dio.post("/product",
        data: {
          "id": product.nameProduct.length * 3,
          "nameProduct": "${product.nameProduct}",
          "price": "${product.price}",
          "category": "Frutas",
          "thumbnail": "teste",
          "isSelected": "false"
        });
    return (response.data);
  }

  Future<int> createProduct(Map<String, dynamic> data) async {
    try {
      var response = await dio.post("/product", data: data);

      debugPrint("NS SUCESSO ${response.statusCode}");

      return response.statusCode;
    } on DioError catch (e) {
      debugPrint("NS ${e.message}");
    }
  }

//  Future<int> createPost(Map<String, dynamic> data) async {
//    try {
//      var response = await _client.post("/posts", data: data);
//      return response.statusCode;
//    } on DioError catch (e) {
//      throw (e.message);
//    }
//  }

}