import 'package:app_sql/components/cart_Model.dart';
import 'package:app_sql/components/cart_provider.dart';
import 'package:app_sql/components/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Dbhelper dbhelper = Dbhelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cartprovider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = screenWidth / 375.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart Screen'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: dbhelper.getcartlist(),
              builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const Center(
                //     child: Text(''),
                //   );
                // } else

                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(
                    child: Center(
                        child: Text(
                      'No items in cart',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textScaleFactor * 30),
                    )),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ( context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            child: Dismissible(
                              key: ValueKey<int>(snapshot.data![index].id!),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                cart.removeCounter();
                                dbhelper.deleteDate(snapshot.data![index].id!);
                                dbhelper.getcartlist();
                                cart.removeTotalprice(
                                    snapshot.data![index].productPrice!);

                                snapshot.data!.remove(snapshot.data![index]);
                              },
                              background: Container(
                                color: Colors.red.withOpacity(.2),
                                child: const Icon(Icons.delete_forever),
                              ),
                              
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5.0,top: 8,bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * .2,
                                        child: Image(
                                            fit: BoxFit.fill,
                                            image: AssetImage(snapshot
                                                .data![index].image
                                                .toString())),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].productName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      textScaleFactor * 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: screenHeight * .019,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Rs. ',
                                                    style: TextStyle(
                                                        color: Colors.white70
                                                            .withGreen(5),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextSpan(
                                                      text: snapshot
                                                          .data![index]
                                                          .productPrice
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              textScaleFactor *
                                                                  20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * .02,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                      int quantity = snapshot
                                                          .data![index]
                                                          .quantity!;
                                                      int price = snapshot
                                                          .data![index]
                                                          .initialPrice!;
                                                      quantity--;
                                                      int newprice;
                                                      newprice =
                                                          quantity * price;
                                                      if (snapshot.data![index]
                                                              .quantity! >
                                                          1) {
                                                        dbhelper
                                                            .updatequantity(CartModel(
                                                                id: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                productId: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                productName: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productName,
                                                                initialPrice: snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice,
                                                                productPrice:
                                                                    newprice,
                                                                productColor: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productColor,
                                                                image: snapshot
                                                                    .data![
                                                                        index]
                                                                    .image,
                                                                quantity:
                                                                    quantity))
                                                            .then((value) {
                                                          quantity = 0;
                                                          newprice = 0;
                                                          price = 0;
                                                          cart.removeTotalprice(
                                                              snapshot
                                                                  .data![index]
                                                                  .initialPrice!);
                                                        });
                                                      }
                                                    },
                                                  
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        
                                                        border: Border.all(color: Colors.black),
                                                        borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Icon(Icons.remove,
                                                            size: textScaleFactor *
                                                                30),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * .02,
                                                ),
                                                Text(
                                                  snapshot.data![index].quantity
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          textScaleFactor * 25),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * .02,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      int quantity = snapshot
                                                          .data![index]
                                                          .quantity!;
                                                      int price = snapshot
                                                          .data![index]
                                                          .initialPrice!;
                                                      quantity++;
                                                      int newprice;
                                                      newprice =
                                                          quantity * price;
                                                      dbhelper
                                                          .updatequantity(CartModel(
                                                              id: snapshot
                                                                  .data![index]
                                                                  .id,
                                                              productId: snapshot
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                              productName: snapshot
                                                                  .data![index]
                                                                  .productName,
                                                              initialPrice: snapshot
                                                                  .data![index]
                                                                  .initialPrice,
                                                              productPrice:
                                                                  newprice,
                                                              productColor: snapshot
                                                                  .data![index]
                                                                  .productColor,
                                                              image: snapshot
                                                                  .data![index]
                                                                  .image,
                                                              quantity:
                                                                  quantity))
                                                          .then((value) {
                                                        quantity = 0;
                                                        newprice = 0;
                                                        price = 0;
                                                        cart.addtotalPrice(
                                                            snapshot
                                                                .data![index]
                                                                .initialPrice!);
                                                      });
                                                    },
                                                    child: Container(
                                                      
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12),
                                                        border: Border.all(color: Colors.black)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                                                        child: Icon(
                                                          Icons.add,
                                                          size:
                                                              textScaleFactor * 30,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              }),
          Visibility(
            visible: cart.getTotalPrice() == 0 ? false : true,
            child: CustomPaint(
              painter: TopElevationPainter(),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: Column(
                    children: [
                      Reuseable(
                          title: 'Total Price',
                          value: cart.getTotalPrice().toDouble()),
                      const Reuseable(title: 'Discount', value: 0),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,bottom: 8),
                        child: SizedBox(
                            width: screenHeight * .4,
                            child: FloatingActionButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_checkout,
                                    size: textScaleFactor * 26,
                                  ),
                                  Text(
                                    '  Place Order ',
                                    style: TextStyle(
                                        fontSize: textScaleFactor * 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Reuseable extends StatelessWidget {
  final String title;
  final double value;
  const Reuseable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double textScaleFactor = screenWidth / 375.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: textScaleFactor * 30, fontWeight: FontWeight.bold)),
        RichText(
            text: TextSpan(children: [
          const TextSpan(text: 'Rs  ', style: TextStyle(color: Colors.black)),
          TextSpan(
              text: value.toString(),
              style: TextStyle(
                  fontSize: textScaleFactor * 30, fontWeight: FontWeight.bold))
        ])),
      ],
    );
  }
}

class TopElevationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]! // Adjust the color as needed
      ..style = PaintingStyle.fill
      ..maskFilter =
          MaskFilter.blur(BlurStyle.normal, 8.0); // Adjust the blur as needed

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, 20) // Adjust the height of the shadow
      ..lineTo(0, 20) // Adjust the height of the shadow
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
