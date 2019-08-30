import 'dart:async';

import 'package:crud_flutter_dio_provider/blocs/product_bloc.dart';
import 'package:crud_flutter_dio_provider/models/Product.dart';
import 'package:flutter/material.dart';
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
                decoration: InputDecoration(
                    labelText: "Preço"
                ),
                validator: (value) => value.isEmpty ? "o preço nao pode ser vazio" : null,
              ),
              RaisedButton(
                child: Text("Cadsatrar"),
                color: Colors.deepPurple,
                onPressed: () {
                  if(formKey.currentState.validate()){
                    var result = bloc.saveProduct(Product(
                        nameProduct: "${nomeProdutoController.text}",
                        price: double.parse(precoController.text),
                        categoryId: 13,
                        thumbnail: "teste"));

                    if(result){
                      nomeProdutoController.text = null;
                      precoController.text = null;
                    }else{
                      print("ERRO AO INSERIR");
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
