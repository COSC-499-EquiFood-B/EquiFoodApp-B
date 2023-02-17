// custom function to display a Snackbar with a given context and text
import 'package:flutter/material.dart';

// function to show a Snackbar
displaySnackbar(context, text) {
  SnackBar snackbar = SnackBar(
    width: 200,
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 2000),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );

  // show snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
