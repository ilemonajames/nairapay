import 'package:flutter/material.dart';

class Inputes {
  AmountInpute(
      {required String hint, required TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.all(13),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
          ),
        )
      ]),
    );
  }


  

  SelectCurrency({ required String selected_  ,  required Function onChanged}) {
    String selected = selected_;
    return StatefulBuilder(builder: (a , setState){
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(13),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: DropdownButton<String>(
          hint: Text("      $selected"),
          underline: Container(),
          items: <String>['USD', 'EUR', 'RAN', 'RUB'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (a) {
            onChanged(a);
            setState((){
            selected = a.toString();
          
            });
          },
        ));
    });
  }


  SelectPayment({ required String selected_ , required Function onChanged}) {
    String selected = selected_;
    return StatefulBuilder(builder: (a , setState){
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(13),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: DropdownButton<String>(
          hint: Text("      $selected"),
          underline: Container(),
          items: <String>['PayPal', 'Interswitch', 'Strip Account'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (a) {
            onChanged(a);
            setState((){
            selected = a.toString();
          
            });
          },
        ));
    });
  }




  TextInpute(
      {required String hint, required TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.all(13),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
