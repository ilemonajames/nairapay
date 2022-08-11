import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nairapay/Helpers/Constants.dart';
import 'package:nairapay/Helpers/Utils.dart';
import 'package:nairapay/Pages/Home.dart';

class LastPageWidget extends StatefulWidget {
  LastPageWidget(
      {super.key, required this.amount, required this.type, this.rec_id});

  double amount;
  String type;
  var rec_id;

  @override
  State<LastPageWidget> createState() => _LastPageWidgetState();
}

class _LastPageWidgetState extends State<LastPageWidget> {
  Future<String> adJustAmount() {
    return Future.delayed(Duration(seconds: 4), () {
      double currentBalance = prefs.getDouble('balance') ?? 0;
      // format : amount,debitorCredit,time,type,rec

      List<String> transactions = prefs.getStringList("transactions") ?? [];

      String transactionTemplate = "";

      if (widget.type == "transfer") {
        prefs.setDouble("balance", currentBalance - widget.amount);

        transactionTemplate =
            "${widget.amount},debit,${new DateTime.now().toLocal()},Transfer,${widget.rec_id}";
      } else if (widget.type == "order") {
        prefs.setDouble("balance", currentBalance - widget.amount);
        transactionTemplate =
            "${widget.amount},debit,${new DateTime.now().toLocal()},Order,${widget.rec_id}";
      } else {
        prefs.setDouble("balance", currentBalance + widget.amount);

        transactionTemplate =
            "${widget.amount},credit,${new DateTime.now().toLocal()},Fund Account,";
      }
      transactions.add(transactionTemplate);
      prefs.setStringList("transactions", transactions);

      return "success";
    });
  }

  @override
  Widget build(BuildContext context) {
    String status = "pending";

    return Scaffold(
      body: FutureBuilder(
        future: adJustAmount(),
        builder: (a, b) {
          if (b.hasData) {
            status = "success";
          } else {}

          return Container(
            color: status == "pending"
                ? yellow
                : status == "success"
                    ? green
                    : red,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Icon(
                    status == "pending"
                        ? Icons.hourglass_empty
                        : status == "success"
                            ? Icons.check_rounded
                            : Icons.cancel,
                    size: 35,
                    color: status == "pending"
                        ? yellow
                        : status == "success"
                            ? green
                            : red,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  status == "pending"
                      ? "Transaction is Processing"
                      : status == "success"
                          ? "Transaction successful"
                          : "Transaction Failed",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  status == "pending"
                      ? "Seems like there is a delay, Please\nWait while we process\nyour transaction"
                      : status == "success"
                          ? "Transaction Completed Successfuly"
                          : "For some reasons, the\nTransaction could not be completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => HomePage()),
                        (route) => false);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 350,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      status == "pending"
                          ? "Track progress"
                          : status == "success"
                              ? "Continue"
                              : "Try Again",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                status == "success"
                    ? Text(
                        "Create Invoice",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}
