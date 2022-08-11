import 'package:flutter/material.dart';
import 'package:nairapay/Helpers/Constants.dart';
import 'package:nairapay/Helpers/LastPage.dart';
import 'package:nairapay/Helpers/Utils.dart';
import 'package:nairapay/Widget/CardInfo.dart';
import 'package:nairapay/Widget/Inputes.dart';

Widget SetupPage() {
  return Scaffold();
}

Future SetupBottom(context, content) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "Card Details & Settings",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Color(0xffE8E8EB),
                    height: 1,
                  ),
                  CardInfo(
                      header: "CARD NAME",
                      sub: "Peter Parker",
                      canCopy: false,
                      canToggle: false),
                  CardInfo(
                      header: "CARD NUMBER",
                      sub: "5399 8859 7680 1624",
                      canCopy: true,
                      canToggle: true),
                  CardInfo(
                      header: "CARD CVV",
                      sub: "124",
                      canCopy: false,
                      canToggle: false),
                  CardInfo(
                      header: "BILLING ADDRESS",
                      sub: "7 Grace Avenue, Mgbuoba, Port-Harcourt, NG",
                      canCopy: false,
                      canToggle: false),
                  CardInfo(
                      header: "ZIP CODE",
                      sub: "121233",
                      canCopy: false,
                      canToggle: false),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      AddCardBottom(context, Container());
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "   Add card   ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(height: 20)
                ],
              ),
            )
          ],
        );
      });
}

Future TransferAmountBottom(context, content) {
  var controller = TextEditingController();
  var rec_controller = TextEditingController();
  String cur = "USD";
  String cur_ = "PayPal";

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            StatefulBuilder(builder: (a, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text(
                        "Tranfer Amount",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Color(0xffE8E8EB),
                      height: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "How much money do you want to \ntransfer ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Inputes()
                        .AmountInpute(hint: "Amount", controller: controller),
                    Inputes().SelectCurrency( selected_: cur, onChanged: (a) {
                      setState(() {
                        cur = a;
                      });
                    }),
                    Inputes().SelectPayment( selected_: cur_, onChanged: (a) {
                      setState(() {
                        cur_ = a;
                      });
                    }),
                    Inputes()
                        .TextInpute(hint: "Enter ID", controller: rec_controller),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "*",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: red),
                          ),
                          Text(
                            " You will be charged NGN51,510.00 at an exchange\nrate of NGN505.00 to ${cur}1.",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.text.isNotEmpty) {
                          var text_ = rec_controller.text.trim();
                          try {
                            double currentBalance =
                                prefs.getDouble('balance') ?? 0;
                            double amount_ =
                                double.parse(controller.text.trim());

                            if (amount_ > currentBalance) {
                              Alart(
                                  context: context,
                                  message: "Low balance. Pluease topup",
                                  isError: true);
                              return;
                            }

                            if (text_.isEmpty) {
                              Alart(
                                  context: context,
                                  message: "Enter a Reciver ID first",
                                  isError: true);
                              return;
                            }

                            Navigator.pop(context);
                            showTransferConfirmation(
                                context, amount_, rec_controller.text);
                          } catch (e) {
                            Alart(
                                context: context,
                                message: "Error parsing amount",
                                isError: false);
                          }
                        } else {
                          Alart(
                              context: context,
                              message: "Enter amount first",
                              isError: false);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          "   Confirm amount   ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    Container(height: 20)
                  ],
                ),
              );
            })
          ],
        );
      });
}

Future FundCardBottom(context, content) {
  var controller = TextEditingController();
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "Fund Card",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Color(0xffE8E8EB),
                    height: 1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "How much money do you want to \nfund the card with ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Inputes()
                      .AmountInpute(hint: "Amount", controller: controller),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "*",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: red),
                        ),
                        Text(
                          " You will be charged NGN51,510.00 at an exchange\nrate of NGN505.00 to USD1.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.text.isNotEmpty) {
                        try {
                          double amount_ = double.parse(controller.text.trim());

                          Navigator.pop(context);
                          showAccountBalace(context, amount_);
                        } catch (e) {
                          Alart(
                              context: context,
                              message: "Error parsing amount",
                              isError: false);
                        }
                      } else {
                        Alart(
                            context: context,
                            message: "Enter amount first",
                            isError: false);
                      }

                      ;
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "   Confirm amount   ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(height: 20)
                ],
              ),
            )
          ],
        );
      });
}

Future AddCardBottom(context, amount) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "Add New Card",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Color(0xffE8E8EB),
                    height: 1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Please note that you will be charged a card\ncreation fee of NGN1,010.00 (USD2).",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showAccountBalace(context, amount);
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "   Continue   ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(height: 20)
                ],
              ),
            )
          ],
        );
      });
}

showAccountBalace(context, amount) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                contentBox(context, amount),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                )
              ]),
        );
      });
}

contentBox(context, amount) {
  return Container(
    margin: EdgeInsets.all(30),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "Confirmation",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
          "card  with number 5399885976801624 \nwill be funded with USD$amount. Do you wish \nto continue?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => LastPageWidget(
                              amount: amount,
                              type: "fund",
                            )));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  "   Yes   ",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: blue.withOpacity(.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "   Cancel   ",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ]),
  );
}

showOrderConfirmation(context, amount) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                contentBox_3(context, amount),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                )
              ]),
        );
      });
}

contentBox_3(context, amount) {
  return Container(
    margin: EdgeInsets.all(30),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "Confirm Purchase",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
          "card  with number 5399885976801624 \nwill be charged USD$amount. Do you wish \nto continue?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => LastPageWidget(
                              amount: amount,
                              type: "order",
                              rec_id: "RDS",
                            )));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  "   Yes   ",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: blue.withOpacity(.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "   Cancel   ",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ]),
  );
}

showTransferConfirmation(context, amount, rec) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                contentBox_1(context, amount, rec),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                )
              ]),
        );
      });
}

contentBox_1(context, amount, rec) {
  return Container(
    margin: EdgeInsets.all(30),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "Confirmation",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
          "You are about to transfer USD$amount to user\nwith ID $rec. Do you wish \nto continue?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => LastPageWidget(
                              amount: amount,
                              type: "transfer",
                              rec_id: rec,
                            )));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  "   Yes   ",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: blue.withOpacity(.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "   Cancel   ",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ]),
  );
}
