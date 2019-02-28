import "package:flutter/material.dart";
import 'package:aacx/Widgets/productCard.dart';
import 'package:aacx/models/products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:aacx/scoped-model/mainn.dart';

class product extends StatelessWidget {
  bool showFav = false;
product({this.showFav});

  Widget buildProductsList(List<Product> products) {

    return products.length > 0
        ? ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Navigator.pushNamed(context, '/products/' + '$index'),
          child: productCard(
            title: products[index].title,
            image: products[index].image,
            price: products[index].price,
            index:  index,
            email: products[index].email,
          ),
        );
      },
      itemCount: products.length,
    )
        : Center(
      child: Text("Press the button!"),
    );


  }

  @override
  Widget build(context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return buildProductsList(!showFav?model.givepro(): model.giveFav());
      },
    );
  }
}
