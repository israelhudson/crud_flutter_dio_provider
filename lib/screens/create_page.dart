import 'dart:async';

import 'package:crud_flutter_dio_provider/blocs/product_bloc.dart';
import 'package:crud_flutter_dio_provider/models/Product.dart';
import 'package:crud_flutter_dio_provider/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  var formKey = GlobalKey<FormState>();
  TextEditingController nomeProdutoController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of<ProductBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cadastro"),),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nomeProdutoController,
                decoration: InputDecoration(
                    labelText: "Produto"
                ),
                validator: (value) => value.isEmpty ? "o produto nao pode ser vazio" : null,
              ),
              TextFormField(
                controller: precoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Preço"
                ),
                validator: (value) => value.isEmpty ? "o preço nao pode ser vazio" : null,
              ),
              RaisedButton(
                child: Text("Cadastrar"),
                color: Colors.green,
                onPressed: () {

                  if(formKey.currentState.validate()){

                    try{
                      bloc.saveProduct(Product(nameProduct: "${nomeProdutoController.text}", price: double.parse(precoController.text), categoryId: 1, thumbnail: ""));

                      alert("GRAVOU");
                      
                      Navigator.pop(context);

                    }catch(e){
                      alert("ERROR "+e.toString());

                    }



                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}

void alert(String text){
  Fluttertoast.showToast(
      msg: "${text}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
