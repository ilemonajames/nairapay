import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nairapay/Helpers/Api.dart';
import 'package:nairapay/Helpers/Constants.dart';
import 'package:nairapay/Helpers/Utils.dart';

import '../Helpers/SetupPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  var controller = PageController(initialPage: 0);
  double currentBalance = 0;

  SingleProduct(
      {required String title,
      required double amount,
      required String desc,
      required String link}) {
    return  GestureDetector(
      onTap: (){
        showOrderConfirmation(context , amount);
      },
      child:  Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    link,
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color(0xff333333), fontSize: 14),
                    ),
                    Text(
                      desc,
                      style: const TextStyle(
                          color: Color(0xffC4C4C4),
                          fontWeight: FontWeight.w400,
                          fontSize: 11),
                    )
                  ],
                )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "\$ ${formatAmount(amount)}",
                  style: TextStyle(
                      color: blue, fontWeight: FontWeight.w500, fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 9,
            ),
          ],
        ))
  
  ,
    )
    ;
    







   
  }
  @override
  Widget build(BuildContext context) {
    currentBalance = prefs.getDouble("balance") ?? 0;
    List<String> transactions = prefs.getStringList("transactions") ?? [];
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        leading: Container(
            child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        )),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "NairaPay",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: blue),
        unselectedIconTheme: IconThemeData(color: Color(0xff646A86)),
        onTap: ((value) => {
              setState(() {
                selected = value;
                controller.jumpToPage(value);
              })
            }),
        currentIndex: selected,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12, color: blue),
        unselectedLabelStyle: TextStyle(
          color: blue,
          fontSize: 12,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_circle_up,
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_2),
            label: 'Products',
          ),
        ],
      ),
      body: FutureBuilder(
          future: MyApi().checkBalance(),
          builder: (a, b) {
            if (b.hasData) {
              return PageView(
                onPageChanged: (index) {
                  setState(() {
                    selected = index;
                  });
                },
                controller: controller,
                children: [
                  SingleChildScrollView(
                    child: Container(
                        child: Column(children: [
                      GestureDetector(
                        onTap: () {
                          SetupBottom(context, Container());
                        },
                        child: Container(
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              height: 185,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(
                                  left: 30, top: 20, bottom: 20, right: 30),
                              decoration: BoxDecoration(
                                  gradient: blue_gradient,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "PETER PARKER",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "E-Naira virtual card",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w100),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                            'assets/images/chip_image.png'),
                                        const Text(
                                          "5399 8859 7680 1624",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OCR',
                                              letterSpacing: 3,
                                              wordSpacing: 4,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "PETER PARKER",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),
                                            Text(
                                              "NGN${formatAmount(currentBalance)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                            Text(
                                              "VALID THRU",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),
                                            Text(
                                              "11/22",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Image.asset('assets/images/vector_2.png'),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOTAL BALANCE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                                Text("\$ ${formatAmount(currentBalance)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.black))
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FundCardBottom(context, Wrap());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: blue.withOpacity(.1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: Text(
                                      "   Fund card   ",
                                      style: TextStyle(color: blue),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    TransferAmountBottom(context, Wrap());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: blue.withOpacity(.1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: Text(
                                      "   Transfer   ",
                                      style: TextStyle(color: blue),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(children: [
                          Row(
                            children: const [
                              Text(
                                "Card Transaction",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          transactions.isEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Image.asset('assets/images/vector_1.png'),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Text(
                                      "Oops... No transactions yet. Your\ntransactions will show up here once\nyou’ve got any.",
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: (transactions.length > 5
                                      ? 5
                                      : transactions.length),
                                  shrinkWrap: true,
                                  itemBuilder: (a, b) {
//      format : amount,debitorCredit,time,type,rec,

                                    List<String> items =
                                        transactions[b].split(",");

                                    String amount = items[0].trim();
                                    String debitOrCredit = items[1].trim();
                                    String time = items[2].trim();
                                    String type = items[3].trim();
                                    String rec = items[4].trim();

                                    return Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 45,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      color: (debitOrCredit ==
                                                              "credit")
                                                          ? green
                                                              .withOpacity(.16)
                                                          : red
                                                              .withOpacity(.16),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Icon(
                                                      (debitOrCredit ==
                                                              "credit")
                                                          ? Icons.check
                                                          : Icons.outbound,
                                                      size: 25,
                                                      color: (debitOrCredit ==
                                                              "credit")
                                                          ? green
                                                          : red),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      time,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xffC4C4C4),
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      '$type ${rec.isEmpty ? "" : "to $rec"}',
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff333333),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                )),
                                                Text(
                                                  "${debitOrCredit == "credit" ? "+" : "-"} \$$amount",
                                                  style: TextStyle(
                                                      color: debitOrCredit ==
                                                              "credit"
                                                          ? green
                                                          : red,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: Colors.grey.shade300,
                                            )
                                          ],
                                        ));
                                  })
                        ]),
                      )
                    ])),
                  ),
                  Container(
                    child: (transactions.length == 0)
                        ? Center(
                            child: Text("No Transactions yet"),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: transactions.length,
                                shrinkWrap: true,
                                itemBuilder: (a, b) {
//      format : amount,debitorCredit,time,type,rec,

                                  List<String> items =
                                      transactions[b].split(",");

                                  String amount = items[0].trim();
                                  String debitOrCredit = items[1].trim();
                                  String time = items[2].trim();
                                  String type = items[3].trim();
                                  String rec = items[4].trim();

                                  return Container(
                                      margin: EdgeInsets.only(
                                          top: 5, left: 10, right: 10),
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          top: 8,
                                          bottom: 8,
                                          right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: (debitOrCredit ==
                                                            "credit")
                                                        ? green.withOpacity(.16)
                                                        : red.withOpacity(.16),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: Icon(
                                                    (debitOrCredit == "credit")
                                                        ? Icons.check
                                                        : Icons.outbound,
                                                    size: 25,
                                                    color: (debitOrCredit ==
                                                            "credit")
                                                        ? green
                                                        : red),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    time,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffC4C4C4),
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    '$type ${rec.isEmpty ? "" : "to $rec"}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              )),
                                              Text(
                                                "${debitOrCredit == "credit" ? "+" : "-"} \$$amount",
                                                style: TextStyle(
                                                    color: debitOrCredit ==
                                                            "credit"
                                                        ? green
                                                        : red,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                        ],
                                      ));
                                })),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SingleProduct(
                            title: "Fingerprint Touch Bluetooth Headset",
                            amount: 2000,
                            desc:
                                "Welcome to my store, For more products,click seller information to enter ourstore for purchase",
                            link:
                                "https://ng.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/93/237687/1.jpg?3307"),
                        SingleProduct(
                            title: "Smart Fashion Breathable Unisex Sneakers",
                            amount: 4200,
                            desc:
                                "Capture a smart look with this effortlessly stylish collection of fabulous footwear.",
                            link:
                                "https://ng.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/96/158366/1.jpg?4920"),
                        SingleProduct(
                            title: "Oblique Zippers Color Block Fleece Hoodie",
                            amount: 3500,
                            desc:
                                "Zip Up hoodie with color block zippers and fleece lining.- Oblique Zip on the front,it is fashionable you'll want to wear it. ",
                            link:
                                "https://ng.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/62/6857001/1.jpg?1237")
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
