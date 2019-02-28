import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import "../scoped-model/mainn.dart";
import '../product.dart';


class HomePage extends StatefulWidget{
  MainModel model;
  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
class HomePageState extends State<HomePage>{
@override
initState(){
  widget.model.fetchProducts();
  super.initState();
}

bool showFav=false;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.favorite), onPressed: () {
              setState(() {
                showFav= !showFav;
              });

            })
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('menu'),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text("manage"),
                onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
              )
            ],
          ),
        ),
        body: ShowBody());
  }

  Widget ShowBody(){
    return ScopedModelDescendant<MainModel>(builder: (context,child,model){
      Widget content = Center(child: Text("no prod found"));
      if(model.products.length>0&&!model.thinkLoading){
        content=product(showFav: showFav);
      }

      else if ( model.thinkLoading){
        content= Center(child: CircularProgressIndicator());
      }

      return content;
    });

}
}
