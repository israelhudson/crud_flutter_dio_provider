import 'dart:collection';

import 'package:crud_flutter_dio_provider/blocs/cart_bloc.dart';
import 'package:crud_flutter_dio_provider/repositories/general_api.dart';
import 'package:crud_flutter_dio_provider/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/product_bloc.dart';
import '../models/Product.dart';
import 'create_page.dart';
import 'package:async/async.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> lista = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();


  @override
  Widget build(BuildContext context) {

    final products = Provider.of<ProductBloc>(context);

    final cart = Provider.of<CartBloc>(context);


    _fetchData() {
      return this._memoizer.runOnce(() async {
        var data = await products.listProducts;
        return data;
      });
    }

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

//          if(lista.isEmpty)
//            bloc.api.getProducts().then((data) => lista = data);
//          if(bloc.items.isEmpty)
//            bloc.fetchData();

          return FutureBuilder(
            //future: bloc.listProducts,
            //future: _memoizer.runOnce(() async => bloc.listProducts),
            future: _fetchData(),
            builder: (context, snapshot){
              return ListView.separated(
                //itemCount: lista.length,
                //itemCount: bloc.items.length,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {

                  //Product product = lista[index];
                  Product product = snapshot.data[index];

                  return Container(
                    child: Card(
                      child: ListTile(
                        title: Text("${product.nameProduct}"),
                        subtitle: Text("R\$ ${product.price}"),
                        trailing: FlatButton(
                          child: Icon(Icons.add_shopping_cart),
                          onPressed: (){
                            cart.add(product);
                          },
                        ),
                        leading: InkWell(
                          child: Icon(Icons.delete),
                          onTap: (){
                            products.delete(product);
                          },
                        ),
                      ),
                      color: !cart.items.contains(product)
                          ? Theme.of(context).accentColor
                          : Colors.green,
                    ),

                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            },
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
          ).whenComplete(()=>products.fetchData());
        },
      ),
    );
  }
}