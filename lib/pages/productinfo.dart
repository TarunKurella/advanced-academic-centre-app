import 'package:flutter/material.dart';
import '../Widgets/priceElement.dart';

import 'package:aacx/models/products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:aacx/scoped-model/mainn.dart';

class productinfo extends StatelessWidget {
  int index;

  productinfo(this.index);

  @override
  Widget build(BuildContext context) {
    showwDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    },
                    child: Text("YES")),
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text("NO")),
              ],
              title: Text("Warning"),
              content: Text("are you sure?"),
            );
          });
    }

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext, Widget child, Productsmodel) {
          Product product=Productsmodel.products[index];
      return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              Image.asset(product.image),
              Text(product.description),
              priceElement(
                price: product.price,
              ),
              RaisedButton(
                  color: Colors.white70,
                  child: Text("delete"),
                  onPressed: () {
                    showwDialog(context);
                  })
            ],
          )));
    });
  }
}
