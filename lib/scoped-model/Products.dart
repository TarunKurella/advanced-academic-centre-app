import 'package:scoped_model/scoped_model.dart';
import '../models/products.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

mixin ProductsModel on Model {
  List<Product> products = [];
  int selected_index;
  bool thinkLoading;
  List<Product> givepro() {
    return List.from(products);
  }

  List<Product> giveFav() {
    List<Product> favpro = [];
    for (var product in products) {
      if (product.isFavourite == true) {
        favpro.add(product);
      }
    }
    return favpro;
  }

  Product getproduct() {
    if (selected_index == null) return null;
    notifyListeners();
    return products[selected_index];
  }

  void toggleFavourite() {
    bool isCurrentlyFavourite = products[selected_index].isFavourite;
    bool isNewFavourite = !isCurrentlyFavourite;
    Product updatedproduct = Product(
        title: products[selected_index].title,
        description: products[selected_index].description,
        price: products[selected_index].price,
        image: products[selected_index].image,
        isFavourite: isNewFavourite);
    products[selected_index] = updatedproduct;
    selected_index = null;
    notifyListeners();
  }

  void deleteProduct() {
    {
      http.delete("https://aac-project-3d7b1.firebaseio.com/products/${products[selected_index].id}.json");
      products.removeAt(selected_index);
      selected_index = null;
      notifyListeners();
    }
    ;
  }

  void addProduct(final Map<String, dynamic> productData) {
    {
      thinkLoading=true;
      http
          .post("https://aac-project-3d7b1.firebaseio.com/products.json",
              body: json.encode(productData))
          .then((http.Response response) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        products.add(Product(
          uid: productData["uid"],
            id: responseData["name"],
            email: productData["email"],
            price: productData["price"],
            title: productData["title"],
            description: productData["description"],
            image: "asset/foood.jpg"));
        selected_index = null;
        thinkLoading=false;
        notifyListeners();
      });
    }
    ;
  }

  void updateProduct(Product) {
    {thinkLoading=true;
      Map<String,dynamic> updatedData = {
        'email': Product.email,
        'price': Product.price,
        'title': Product.title,
        'description': Product.description,
        'image': "asset/foood.jpg",
        "uid"  : Product.uid

      };
      http.put("https://aac-project-3d7b1.firebaseio.com/products/${products[selected_index].id}.json",body: jsonEncode(updatedData));
      products[selected_index] = Product;
      selected_index = null;
      notifyListeners();
    }
    ;
  }

  void selectIndex(int index) {
    selected_index = index;
    thinkLoading=false;
    notifyListeners();
  }

  void fetchProducts({String uid = null}) {
    thinkLoading=true;
    http
        .get("https://aac-project-3d7b1.firebaseio.com/products.json")
        .then((http.Response response) {
          List<Product> fetchpro = [];

      final Map<String, dynamic> productlistdata =
          json.decode(response.body);
      print(productlistdata);

      if(productlistdata == null){
        thinkLoading = false;
        notifyListeners();
        return;

      }

      productlistdata
          .forEach((String productId, dynamic productData) {
            Product product = new Product(
                uid: productData["uid"] ,
                id: productId,
                email: productData["email"],
                price: productData["price"],
                title: productData["title"],
                description: productData["description"],
                image: "asset/foood.jpg");
            if(uid!=null){
              if(product.uid==uid){
                fetchpro.add(product);
              }
            }else{

            fetchpro.add(product);}
            products=fetchpro;

            thinkLoading=false;
            notifyListeners();


      });
    });
  }
}
