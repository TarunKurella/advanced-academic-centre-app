import 'package:flutter/material.dart';
import 'package:aacx/models/products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:aacx/scoped-model/mainn.dart';

class ProductEdit extends StatefulWidget {
  ProductEdit();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductEditState();
  }
}

class ProductEditState extends State<ProductEdit> {
  String title;
  String description;
  double price;
  Product product;
  String email;
  String uid;
  final focusnode2 = FocusNode();
  final focusnode3 = FocusNode();
  Map<String, dynamic> formData = {
    "name": null,
    "desc": null,
    "price": null,
    "image": "asset/foood.jpg"
  };

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Widget buildTitle(productItem) {
    return Card(
      color: Colors.black45.withOpacity(0.0),
      child: TextFormField(
        initialValue: productItem != null ? productItem.title : "",
        validator: (String value) {
          if (value.isEmpty || value.length < 3) {
            return 'title cannot be empty';
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(labelText: "Title"),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(focusnode2);
        },
        onSaved: (String valuee) {
          setState(() {
            formData["name"] = valuee;
          });
        },
      ),
    );
  }

  Widget buildDesc(productItem) {
    return Card(
        color: Colors.black45.withOpacity(0.0),
        child: TextFormField(
          initialValue: productItem != null ? productItem.description : "",
          validator: (String value) {
            if (value.isEmpty || value.length < 3) {
              return 'Cant have that short description';
            }
          },
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(focusnode3);
          },
          focusNode: focusnode2,
          maxLines: 3,
          decoration: InputDecoration(labelText: "Description"),
          onSaved: (String valuee) {
            setState(() {
              formData["desc"] = valuee;
            });
          },
        ));
  }

  Widget buildPrice(productItem) {
    return Card(
        color: Colors.black45.withOpacity(0.0),
        child: TextFormField(
          initialValue: productItem != null ? productItem.price.toString() : "",
          textInputAction: TextInputAction.done,
          focusNode: focusnode3,
          decoration: InputDecoration(labelText: " How much"),
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) {
            focusnode3.unfocus();
          },
          validator: (value) {
            if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return ' Enter numbers only';
            }
          },
          onSaved: (String valuee) {
            setState(() {
              formData["price"] = double.parse(valuee);
            });
          },
        ));
  }

  void submitForm(Function addProduct, Function updateProduct, int index) {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    setState(() {
      if (index == null) {
        final Map<String, dynamic> productData = {
          'email': email,
          'price': formData["price"],
          'title': formData["name"],
          'description': formData["desc"],
          'image': "asset/foood.jpg",
          'uid'  : uid
        };
        addProduct(productData);
      } else {
        updateProduct(
          Product(
              uid  : uid,
              email: email,
              price: formData["price"],
              title: formData["name"],
              description: formData["desc"],
              image: "asset/foood.jpg"),
        );
      }
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  Widget buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget, ProductsModel) {
        email = ProductsModel.authenticatedUser.email;
        uid=ProductsModel.authenticatedUser.id;
        return ProductsModel.thinkLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text("Save"),
                onPressed: () => submitForm(ProductsModel.addProduct,
                    ProductsModel.updateProduct, ProductsModel.selected_index));
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              buildTitle(product),
              buildDesc(product),
              buildPrice(product),
              SizedBox(
                height: 10.0,
              ),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, ProductsModel) {
        product = ProductsModel.getproduct();

        return ProductsModel.selected_index == null
            ? _buildPageContent(context, product)
            : Scaffold(
                appBar: AppBar(
                  title: Text("Update Item"),
                ),
                body: _buildPageContent(context, product),
              );
      },
    );
  }
}

//brew update
//brew uninstall --ignore-dependencies libimobiledevice
//brew uninstall --ignore-dependencies usbmuxd
//brew install --HEAD usbmuxd
//brew unlink usbmuxd
//brew link usbmuxd
//brew install --HEAD libimobiledevice
