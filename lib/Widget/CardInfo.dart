import 'package:flutter/material.dart';
import 'package:nairapay/Helpers/Constants.dart';

CardInfo({header, sub, required bool canCopy, required bool canToggle}) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    child: Column(children: [
      Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(header,
                  style: TextStyle(fontSize: 12, color: Color(0xff9C9A9A))),
              SizedBox(
                height: 10,
              ),
              Text(
                sub,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              )
            ],
          )),
          canToggle
              ? Icon(
                  Icons.visibility_off,
                  color: Colors.grey.shade300,
                )
              : Container(),
          SizedBox(
            width: 30,
          ),
          canCopy
              ? Icon(
                  Icons.copy,
                  color: blue,
                )
              : Container()
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        width: double.infinity,
        color: Color(0xffE8E8EB),
        height: 1,
      )
    ]),
  );
}
