import 'package:e_com_rev/headers.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropDownValue;

  TextStyle textStyle = TextStyle(
    fontSize: 20,
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  @override

  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    double h = s.height;
    double w = s.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E Commerce App",
          style: TextStyle(
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRoutes.cartpage).then((val)=>setState((){}));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  DropdownButton<String>(
                      value: dropDownValue,
                      dropdownColor: appBarColor,
                      hint: Text(
                        "All",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      items: AllData.allCategories
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          dropDownValue = val ?? "All";
                        });
                      }),
                  Visibility(
                    visible: dropDownValue != null,
                    child: ActionChip(
                      label: Text("Reset"),
                      avatar: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          dropDownValue = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Column(
                children: [
                  ...AllData.allCategories
                      .map(
                        (e) => (dropDownValue == null) ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: textColor,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Row(
                                children: AllData.allProduct
                                    .map(
                                      (i) => (e == i['category'])
                                      ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context)
                                            .pushNamed(
                                            MyRoutes.detailpage,
                                            arguments: i);

                                      });

                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin:
                                          const EdgeInsets.only(
                                            left: 15,
                                          ),
                                          height: h * 0.4,
                                          width: w * 0.5,
                                          decoration: BoxDecoration(
                                            color: containerColor,
                                            borderRadius:
                                            BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(5, 5),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .vertical(
                                                      top: Radius
                                                          .circular(
                                                          18),
                                                    ),
                                                    image:
                                                    DecorationImage(
                                                      image: NetworkImage(
                                                          i['thumbnail']),
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment
                                                      .topLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                          left: 5,
                                                        ),
                                                        child: Text(
                                                          i['title'],
                                                          style:
                                                          textStyle,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                              left: 5,
                                                            ),
                                                            child:
                                                            Text(
                                                              "\$ ${i['price']}",
                                                              style:
                                                              TextStyle(
                                                                decoration:
                                                                TextDecoration.lineThrough,
                                                                decorationColor:
                                                                Colors.red,
                                                                color:
                                                                textColor,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize:
                                                                20,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            " ${(i['price'] - (i['price'] * (i['discountPercentage'] / 100)))}"
                                                                .split(
                                                                ".")[0],
                                                            style:
                                                            textStyle,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                          left: 5,
                                                        ),
                                                        child: Text(
                                                          i['brand'],
                                                          style:
                                                          textStyle,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: i[
                                                            'rating']
                                                                .toDouble(),
                                                            itemBuilder:
                                                                (context, index) =>
                                                                Icon(
                                                                  Icons
                                                                      .star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                            itemCount:
                                                            5,
                                                            itemSize:
                                                            18.0,
                                                            direction:
                                                            Axis.horizontal,
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () {
                                                              if (AllData
                                                                  .cartProducts
                                                                  .contains(i)) {
                                                                AllData
                                                                    .cartProducts
                                                                    .remove(i);
                                                              } else {
                                                                AllData
                                                                    .cartProducts
                                                                    .add(i);
                                                              }
                                                              setState(
                                                                      () {});
                                                            },
                                                            icon:
                                                            Icon(
                                                              AllData.cartProducts.contains(i)
                                                                  ? CupertinoIcons.cart_badge_minus
                                                                  : CupertinoIcons.cart_badge_plus,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : Container(),
                                )
                                    .toList(),
                              ),
                            ),
                          ],
                        ) : (dropDownValue == e) ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: textColor,
                            ),),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Row(
                                children: AllData.allProduct
                                    .map(
                                      (i) => (dropDownValue == i['category'])
                                      ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context)
                                            .pushNamed(
                                            MyRoutes.detailpage,
                                            arguments: i);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin:
                                          const EdgeInsets.only(
                                            left: 15,
                                          ),
                                          height: h * 0.5,
                                          width: w * 0.5,
                                          decoration: BoxDecoration(
                                            color: containerColor,
                                            borderRadius:
                                            BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(5, 5),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .vertical(
                                                      top: Radius
                                                          .circular(
                                                          18),
                                                    ),
                                                    image:
                                                    DecorationImage(
                                                      image: NetworkImage(
                                                          i['thumbnail']),
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment
                                                      .topLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                          left: 5,
                                                        ),
                                                        child: Text(
                                                          i['title'],
                                                          style:
                                                          textStyle,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                              left: 5,
                                                            ),
                                                            child:
                                                            Text(
                                                              "\$ ${i['price']}",
                                                              style:
                                                              TextStyle(
                                                                decoration:
                                                                TextDecoration.lineThrough,
                                                                decorationColor:
                                                                Colors.red,
                                                                color:
                                                                textColor,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize:
                                                                20,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            " ${(i['price'] - (i['price'] * (i['discountPercentage'] / 100)))}"
                                                                .split(
                                                                ".")[0],
                                                            style:
                                                            textStyle,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                          left: 5,
                                                        ),
                                                        child: Text(
                                                          i['brand'],
                                                          style:
                                                          textStyle,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: i[
                                                            'rating']
                                                                .toDouble(),
                                                            itemBuilder:
                                                                (context, index) =>
                                                                Icon(
                                                                  Icons
                                                                      .star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                            itemCount:
                                                            5,
                                                            itemSize:
                                                            18.0,
                                                            direction:
                                                            Axis.horizontal,
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () {
                                                              if (AllData
                                                                  .cartProducts
                                                                  .contains(i)) {
                                                                AllData
                                                                    .cartProducts
                                                                    .remove(i);
                                                              } else {
                                                                AllData
                                                                    .cartProducts
                                                                    .add(i);
                                                              }
                                                              setState(
                                                                      () {});
                                                            },
                                                            icon:
                                                            Icon(
                                                              AllData.cartProducts.contains(i)
                                                                  ? CupertinoIcons.cart_badge_minus
                                                                  : CupertinoIcons.cart_badge_plus,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : Container(),
                                )
                                    .toList(),
                              ),
                            ),
                          ],
                        ) :Container(),
                      )
                      .toList(),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
