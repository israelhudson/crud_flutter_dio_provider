import 'dart:collection';

import 'package:crud_flutter_dio_provider/blocs/cart_bloc.dart';
import 'package:crud_flutter_dio_provider/repositories/general_api.dart';
import 'package:crud_flutter_dio_provider/screens/cart_page.dart';
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

    final cart = Provider.of<CartBloc>(context);

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
                child: Text("${cart.items.length}"),
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
                    return Container(
                      child: ListTile(
                        title: Text(product.nameProduct),
                        trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: (){
                            cart.add(product);
                          },
                        ),
                      ),
                      color: !cart.items.contains(product)
                          ? Theme.of(context).accentColor
                          : Colors.green,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
      ),
    );
  }
}
