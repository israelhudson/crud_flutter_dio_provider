import 'dart:collection';

import 'package:crud_flutter_dio_provider/repositories/general_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/product_bloc.dart';
import '../models/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final products = Provider.of<ProductBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Feira da Fruta"),
        centerTitle: true,
        leading:
        Align(alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.shopping_cart),
              Container(
                alignment: Alignment.center,
                color: Colors.blueGrey,
                width: 20,
                height: 20,
                child: Text("0"),
              )
            ],
          ),
        ),
      ),

      body: Container(
        child: FutureBuilder(
            //future: products.api.getProducts(),
            future: products.listProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {

                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Product product = snapshot.data[index];
                    return ListTile(
                      title: Text(product.nameProduct),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );

              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      )
    );
  }
}
