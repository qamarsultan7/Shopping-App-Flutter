import 'package:app_sql/Screens/cart_screen.dart';
import 'package:app_sql/Screens/details.dart';
import 'package:app_sql/components/cart_provider.dart';
import 'package:app_sql/components/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "Hand bag",
    "Jewellery",
    "Footwear",
    "Dresses",
    "Footwear",
    "Dresses",
  ];
  int selected = 0;
  void changeindex(index) {
    selected = index;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double textScaleFactor = screenWidth / 375.0;

    return Scaffold(
        
        appBar: AppBar(
          
          centerTitle: false,
          title: const Text(
            'Soping App in Flutter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
             Icon(
              Icons.search,
              size: textScaleFactor * 25,
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CartScreen()));
                },
                child: badges.Badge(
                    badgeContent: Consumer<Cartprovider>(
                      builder: (context, value, child) {
                        return Text(
                          value.getCounter().toString(),
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: textScaleFactor * 25,
                    ))),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              changeindex(index);
                              setState(() {});
                            },
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                  color: selected == index
                                      ? Colors.white
                                      : Colors.white24,
                                  fontWeight: selected == index
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                  fontSize: 20),
                            ),
                          ),
                          Visibility(
                            visible: selected == index ? true : false,
                            child: Container(
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 1.5 / 2.4,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3,
                            maxCrossAxisExtent: 300),
                    itemCount: products.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Details(
                                        indexxx: position,
                                        productimg: products[position].image,
                                        name: products[position].title,
                                        description:
                                            products[position].description,
                                        detailcolor:
                                            products[position].productcolor,
                                        size: products[position].size,
                                        price: products[position].price,
                                      )));
                        },
                        child: Card(
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1.9 / 2.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: products[position].productcolor,
                                  ),
                                  child: Center(
                                    child: Image(
                                        image: AssetImage(
                                            products[position].image)),
                                  ),
                                ),
                              ),
                              Text(
                                products[position].title,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text('Rs. ' + products[position].price.toString())
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
