import 'package:crud_flutter_dio_provider/home_page.dart';
import 'package:crud_flutter_dio_provider/shared/custom_dio.dart';
import 'package:crud_flutter_dio_provider/shared/general_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/Cart.dart';
import 'models/Product.dart';

void main(){
  Provider.debugCheckInvalidValueType = null;

  runApp(
      MultiProvider(
        providers: [
          Provider.value(
            value: CustomDio(),
          ),
          ProxyProvider<CustomDio, ProductModel>(
            // Dependency injection
            builder: (context, api, homeModel) => ProductModel(GeneralApi(api.getClient())),
          ),
          ProxyProvider<CustomDio, GeneralApi>(
            // Dependency injection
            builder: (context, api, homeModel) => GeneralApi(api.getClient()),
          ),
          ChangeNotifierProvider(
            builder: (context) => Cart(),
          ),
//          ChangeNotifierProvider(
//            builder: (context) => ProductModel(),
//          ),
        ],
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}