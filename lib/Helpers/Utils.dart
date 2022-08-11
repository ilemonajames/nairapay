import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nairapay/Helpers/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class ValidateEmail {
  bool isEmailValid(var email) {
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return isValid;
  }
}

String formatAmount(number) {
  var formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(number);
}


Alart(
    {required BuildContext context,
    @required String? message,
    @required bool? isError}) {
  Flushbar? flush;
  flush = Flushbar(
    title: "Alert",
    message: message,
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    backgroundColor: isError! ? red : blue,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(20),
    icon: const Icon(
      Icons.info_outline,
      color: Colors.white,
    ),
    mainButton: TextButton(
      onPressed: () {
        flush!.dismiss(true); // result = true
      },
      child: const Text(
        "Ok",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
  flush.show(context);
}