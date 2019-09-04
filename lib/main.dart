import 'package:crud_flutter_dio_provider/screens/home_page.dart';
import 'package:crud_flutter_dio_provider/shared/custom_dio.dart';
import 'package:crud_flutter_dio_provider/repositories/general_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/cart_bloc.dart';
import 'blocs/product_bloc.dart';

void main(){
  Provider.debugCheckInvalidValueType = null;

  runApp(
      MultiProvider(
        providers: [
          Provider.value(
            value: CustomDio(),
          ),
          ChangeNotifierProxyProvider<CustomDio, ProductBloc>(
            // Dependency injection
            builder: (context, api, homeModel) => ProductBloc(GeneralApi(api.getClient())),
          ),
          ProxyProvider<CustomDio, GeneralApi>(
            // Dependency injection
            builder: (context, api, homeModel) => GeneralApi(api.getClient()),
          ),
          ChangeNotifierProvider(
            builder: (context) => CartBloc(),
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