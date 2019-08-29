import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final products = Provider.of<ProductModel>(context);

    //products.api.getProducts();


    return Scaffold(
      appBar: AppBar(
        title: Text("Feira da Fruta"),
        centerTitle: true,
        leading:
        Align(alignment: Alignment.center,
          child: InkWell(
            onTap: (){
              products.api.getProducts().then((p){
                //print(p.nameProduct);
                p.forEach((data){
                  debugPrint("doido "+data.nameProduct);
                });
              });


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
                  child: Text("0"),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: products.items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products.items[index].nameProduct),
              //onTap: ()=> cartBloc.removeCarrinho(products[index]),
              //selected: products[index].isSelected ? true : false,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      )
    );
  }
}
