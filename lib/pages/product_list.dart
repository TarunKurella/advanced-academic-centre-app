import 'package:flutter/material.dart';
import './product_create.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:aacx/scoped-model/mainn.dart';
class ProductList extends StatefulWidget{
  MainModel model;
  ProductList(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListState();
  }

}


class ProductListState extends State<ProductList> {

  @override
  initState(){
    widget.model.fetchProducts(uid: widget.model.authenticatedUser.id );
    super.initState();
  }




  @override
  Widget build(BuildContext context) {


    return  ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, ProductsModel) {
        if ( ProductsModel.thinkLoading){
          return Center(child: CircularProgressIndicator());
        }else{
        return ListView.builder(
          itemBuilder: (context, int index) {

            return Dismissible(
              key: Key(ProductsModel.products[index].title),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  ProductsModel.selected_index = index;
                  ProductsModel.deleteProduct();
                }
              },
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    ProductsModel.selected_index = index;
                    print(ProductsModel.authenticatedUser.id);
                    print("/n and");
                    print(ProductsModel.products[index].uid);
                    return ProductEdit();
                  }));
                },
                title: Text(ProductsModel.products[index].title),
                leading: CircleAvatar(
                  child: Image.asset(ProductsModel.products[index].image),
                ),
              ),
            );
          },
          itemCount: ProductsModel.products.length,
        );}
      },
    );
  }
}
