import 'package:flutter/material.dart';
import 'home.dart';
import './product_create.dart';
import './product_list.dart';
import '../models/products.dart';
import 'package:scoped_model/scoped_model.dart';
import "../scoped-model/mainn.dart";


class productAdmin extends StatelessWidget {
  MainModel model;
  productAdmin(this.model);
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          
          appBar: AppBar(bottom: TabBar(tabs: <Widget>[Tab(icon: Icon(Icons.create),),Tab(icon: Icon(Icons.list))]),
            title: Text("manage"),
          ),
          body: TabBarView(children: <Widget>[ProductEdit(),ProductList(model)]),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text('menu'),
                  automaticallyImplyLeading: false,
                ),
                ListTile(
                  title: Text("Home"),
                  onTap: () => Navigator.pushReplacementNamed(context,"/"
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
