// custom function to display an Alert with a given context and text
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// function to render Pop Up if the fields are empty
displayAlert(BuildContext context, String text) {
  // set up the Button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // Alert
  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text(text),
    actions: [
      // Button
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
