// ignore_for_file: avoid_print

import 'package:app_sql/components/cart_Model.dart';
import 'package:app_sql/components/cart_provider.dart';
import 'package:app_sql/components/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String name, description;
  final String productimg;
  final int size, price, indexxx;
  final Color detailcolor;
  const Details(
      {Key? key,
      required this.name,
      required this.description,
      required this.detailcolor,
      required this.price,
      required this.productimg,
      required this.indexxx,
      required this.size})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Dbhelper dbhelper = Dbhelper();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cartprovider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = screenWidth / 375.0;
    return Scaffold(
      backgroundColor: widget.detailcolor,
      appBar: AppBar(
        backgroundColor: widget.detailcolor,
        elevation: 0,
       
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  EdgeInsets.only(top: screenHeight * .1, left: 30, right: 30),
              height: screenHeight / 1.8,
              width: screenWidth,
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                      fontSize: textScaleFactor * 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    dotcolor(
                                      colorsdot: widget.detailcolor,
                                    ),
                                    const dotcolor(
                                      colorsdot: Colors.red,
                                    ),
                                    const dotcolor(
                                      colorsdot: Colors.yellow,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                             
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size',
                                  style: TextStyle(
                                      fontSize: textScaleFactor * 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.size.toString(),
                                  style:
                                      TextStyle(fontSize: textScaleFactor * 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(widget.description,
                          style: TextStyle(
                            fontSize: textScaleFactor * 16,
                          )),
                      SizedBox(
                        height: screenHeight * .01,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              quantity--;
                              setState(() {});
                            },
                            child: Card(
                              color: widget.detailcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.remove,
                                size: textScaleFactor * 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * .01,
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                                fontSize: textScaleFactor * 23,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: screenWidth * .01,
                          ),
                          GestureDetector(
                            onTap: () {
                              quantity++;
                              setState(() {});
                            },
                            child: Card(
                              color: widget.detailcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.add,
                                size: textScaleFactor * 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: widget.detailcolor,
                            radius: 30,
                            child: Icon(
                              Icons.shopping_cart_checkout,
                              color: Colors.black,
                              size: textScaleFactor * 25,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                int newprice;
                                int price=widget.price;
                                newprice=quantity*price;
                                dbhelper
                                    .insert(CartModel(
                                        productColor:
                                            widget.detailcolor.toString(),
                                        id: widget.indexxx,
                                        productId: widget.indexxx.toString(),
                                        productName: widget.name,
                                        initialPrice: widget.price,
                                        productPrice: newprice,
                                        image: widget.productimg,
                                        quantity: quantity))
                                    .then((value) {
                                      quantity=1;
                                      cart.addtotalPrice(newprice);
                                      cart.addcounter();
                                   SnackBar snackBar = SnackBar(
                                    content:const Text('Product is added to cart'),
                                    backgroundColor: widget.detailcolor,
                                    duration:const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  print('Product is added to cart');
                                }).onError((error, stackTrace) {
                                  const SnackBar snackBar = SnackBar(
                                    content: Text('Product is Already in cart'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  print(error.toString());
                                });
                              },
                              child: Card(
                                color: widget.detailcolor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Add To Cart',
                                      style: TextStyle(
                                          fontSize: textScaleFactor * 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30 * textScaleFactor),
                ),
                SizedBox(
                  height: screenHeight * .05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15 * textScaleFactor)),
                          RichText(
                            text: TextSpan(
                                text: 'Rs.',
                                style: TextStyle(
                                    fontSize: 19 * textScaleFactor,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: widget.price.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30 * textScaleFactor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * .3,
                        child: Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(widget.productimg),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class dotcolor extends StatelessWidget {
  final Color colorsdot;
  const dotcolor({super.key, required this.colorsdot});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 2),
      padding: const EdgeInsets.all(5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
        ),
        color: colorsdot,
      ),
    );
  }
}
