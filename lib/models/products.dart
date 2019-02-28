class Product {
  String id;
  String title;
  String description;
  double price;
  String image;
  bool isFavourite;
  String email;
  String uid;

  Product({this.id,this.price,this.title,this.description,this.image,this.isFavourite = false,this.email=" ",this.uid=" "});


}