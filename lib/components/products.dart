import 'package:flutter/material.dart';

class Product {
  String title,image,description;
  int id,size,price;
  Color productcolor;
  Product({
    required this.title,
    required this.description,
    required this.image,
    required this.id,
    required this.size,
    required this.price,
    required this.productcolor,
  });
}
List<Product> products=[
Product(
      id: 1,
      title: "Office Code",
      price: 234,
      size: 12,
      description: productdescript,
      image: "assets/images/bag_1.png",
      productcolor:const Color(0xFF3D82AE)),
Product(
      id: 2,
      title: "Belt Bag",
      price: 234,
      size: 8,
      description: productdescript,
      image: "assets/images/bag_2.png",
      productcolor:const Color(0xFFD3A984)),
Product(
      id: 3,
      title: "Hang Top",
      price: 234,
      size: 10,
      description: productdescript,
      image: "assets/images/bag_3.png",
      productcolor:const Color(0xFF989493)),
Product(
      id: 4,
      title: "Old Fashion",
      price: 234,
      size: 11,
      description: productdescript,
      image: "assets/images/bag_4.png",
      productcolor:const Color(0xFFE6B398)),
Product(
      id: 5,
      title: "Office Code",
      price: 234,
      size: 12,
      description: productdescript,
      image: "assets/images/bag_5.png",
      productcolor:const Color(0xFFFB7883)),
Product(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 12,
    description: productdescript,
    image: "assets/images/bag_6.png",
    productcolor:const Color(0xFFAEAEAE),
  ),
];

String productdescript='Design and images Copied from TheFlutterWay,but I write my own code to clone the Design\nName:- Qamar Sultan,';