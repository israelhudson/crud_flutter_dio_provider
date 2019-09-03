import 'dart:collection';

import 'package:crud_flutter_dio_provider/blocs/cart_bloc.dart';
import 'package:crud_flutter_dio_provider/repositories/general_api.dart';
import 'package:crud_flutter_dio_provider/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/product_bloc.dart';
import '../models/Product.dart';
import 'create_page.dart';

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
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.shopping_cart),
                Container(
                  alignment: Alignment.center,
                  color: Colors.blueGrey,
                  width: 20,
                  height: 20,
                  //child: Text("${cart.items.length}"),
                  child: Text("${cart.items.length}"),
                )
              ],
            ),
          ),
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(5),
        child: Consumer<ProductBloc>(builder: (context, bloc, child){
          return FutureBuilder(
            //future: products.api.getProducts(),
              future: products.listProducts,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.done || snapshot.hasData == true) {
                  List<Product> listProd = snapshot.data;

                  return ListView.separated(
                    itemCount: listProd.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          child: ListTile(
                            title: Text("${listProd[index].nameProduct}"),
                            subtitle: Text("R\$ ${listProd[index].price}"),
                            trailing: FlatButton(
                              child: Icon(Icons.add_shopping_cart),
                              onPressed: (){
                                cart.add(listProd[index]);
                              },
                            ),
                            leading: InkWell(
                              child: Icon(Icons.delete),
                              onTap: (){
                                products.delete(listProd[index]);
                              },
                            ),
                          ),
                          color: !cart.items.contains(listProd[index])
                              ? Theme.of(context).accentColor
                              : Colors.green,
                        ),

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
          );
        }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage()),
          );
        },
      ),
    );
  }
}