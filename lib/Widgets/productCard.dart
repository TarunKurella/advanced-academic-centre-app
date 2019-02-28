import 'package:flutter/material.dart';
import 'priceElement.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:aacx/scoped-model/mainn.dart';
import 'package:aacx/models/products.dart';

class productCard extends StatelessWidget {
  String image, title;
  double price;
  int index;
  String email;

  productCard({this.title, this.image, this.price, this.index,this.email});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 140.0,
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w400),
                      ),
                    ),Center(
                      child: Text(
                        email,
                        style: TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(child: Icon(Icons.info)),
                        SizedBox(
                          width: 20.0,
                        ),
                        Center(
                          child: ScopedModelDescendant<MainModel>(
                              builder: (context, Widget, ProductsModel) {
                            return IconButton(
                                icon: Icon(
                                    ProductsModel.products[index].isFavourite
                                        ? Icons.favorite
                                        : Icons.favorite_border),
                                onPressed: () {
                                  ProductsModel.selected_index = index;
                                  ProductsModel.toggleFavourite();
                                });
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              priceElement(
                price: price,
              )
            ],
          )
        ],
      ),
    );
  }
}
