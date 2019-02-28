import 'package:flutter/material.dart';

class priceElement extends StatelessWidget{
  double price;
  priceElement({this.price});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(padding: EdgeInsets.only(top: 10.0, left: 3.0),
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,),
      margin: EdgeInsets.only(left: 65.0),
      child: Text("\$$price",
        style: TextStyle(color: Colors.black45, fontSize: 12.0),),
    );
  }
}