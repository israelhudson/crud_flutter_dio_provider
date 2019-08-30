import 'package:crud_flutter_dio_provider/blocs/cart_bloc.dart';
import 'package:crud_flutter_dio_provider/blocs/product_bloc.dart';
import 'package:crud_flutter_dio_provider/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"), centerTitle: true,
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
        ),),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: ()=>cart.remove(cart.items[index]),
                      child: ListTile(
                        title: Text(cart.items[index].nameProduct),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
