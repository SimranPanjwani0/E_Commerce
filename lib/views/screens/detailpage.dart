import 'package:e_com_rev/headers.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextStyle textStyle = TextStyle(
    fontSize: 30,
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  Color iconColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    double h = s.height;
    double w = s.width;

    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...List.generate(
                    data['images'].length,
                    (index) => Container(
                      height: h * 0.7,
                      width: w * 0.7,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            data['images'][index],
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: Text(
                            data['title'],
                            style: textStyle,
                          ),
                        ),
                        // SizedBox(
                        //   width: w * 0.2,
                        // ),
                        // IconButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       if(iconColor == Colors.grey.shade300)
                        //         {
                        //           iconColor = Colors.red;
                        //         }
                        //     });
                        //   },
                        //   icon: Icon(
                        //     Icons.favorite_outline_rounded,
                        //     size: 30,
                        //     color: iconColor,
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                            top: 18,
                          ),
                          child: Text(
                            "Price",
                            style: textStyle,
                          ),
                        ),
                        SizedBox(
                          width: w * 0.35,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 18,
                          ),
                          child: Text("Discount", style: textStyle),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                            top: 7,
                          ),
                          child: Text(
                            "\$ ${data['price'].toString()}",
                            style: TextStyle(
                              fontSize: 25,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 7,
                          ),
                          child: Text(
                            "${data['discountPercentage'].toString()}%",
                            style: TextStyle(
                              fontSize: 25,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          data['brand'],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                      ),
                      child: Text(
                        data['description'],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
