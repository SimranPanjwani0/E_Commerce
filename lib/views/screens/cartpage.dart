import 'package:e_com_rev/headers.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  num value = 0;
  num qty = 1;

  TextStyle textStyle = TextStyle(
    fontSize: 20,
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllData.cartProducts.forEach((e) {
      value = value +
          ((e['price'] - (e['price'] * (e['discountPercentage'] / 100))) * qty);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    double h = s.height;
    double w = s.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart Page",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ...AllData.cartProducts
                    .map(
                      (e) => Card(
                        color: appBarColor,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(e['thumbnail']),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 150,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['title'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "\$${(e['price'] - (e['price'] * (e['discountPercentage'] / 100)))}"
                                          .split(".")[0],
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      e['description'],
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: textColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 120,
                                        top: 20,
                                      ),
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (qty > 0) {
                                                      qty -= 1;
                                                    }
                                                    if (qty == 0) {
                                                      AllData.cartProducts
                                                          .remove(e);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: textColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.horizontal_rule,
                                                    color: appBarColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: appBarColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "$qty",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    qty += 1;
                                                    value += (e['price'] -
                                                        (e['price'] *
                                                            (e['discountPercentage'] /
                                                                100)));
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: textColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: appBarColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: h * 0.1,
                width: w,
                decoration: BoxDecoration(
                  color: appBarColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount : ",
                        style: textStyle,
                      ),
                      Text(
                        (AllData.cartProducts.isNotEmpty
                            ? "\$ $value".split(".")[0]
                            : "\$ 0"),
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
