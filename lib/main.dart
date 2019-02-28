import 'package:flutter/material.dart';
import './pages/Auth.dart';
import './pages/productAdmin.dart';
import './pages/home.dart';
import './pages/productinfo.dart';
import './pages/testin.dart';
import './pages/product_create.dart';
import 'models/products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:aacx/scoped-model/mainn.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _myApp();
  }
}

class _myApp extends State<myApp> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final MainModel model= MainModel();
    return ScopedModel<MainModel>(model: model,child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      theme: ThemeData.dark(),
      routes: {
        '/admin': (context) =>
            productAdmin(model),
        '/': (context) => HomePage(model),
        '/auth': (context) => Autho(),
        '/edit': (context) => ProductEdit(),
      },
      onGenerateRoute: (RouteSettings path) {
        final List<String> pathElements = path.name.split("/");
        int index;
        index = int.parse(pathElements[2]);
        return MaterialPageRoute<bool>(
            builder: (context) => productinfo(index));
      },
    ));
  }
}
