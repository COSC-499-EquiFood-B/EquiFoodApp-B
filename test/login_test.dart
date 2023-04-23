// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:equi_food_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Finds a text in the login widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginWidget(),
    ));

    await tester.pumpAndSettle(const Duration(seconds: 5));
    // verify that our counter starts at 0
    expect(find.text('Sign In'), findsWidgets);
    expect(find.text('Hello'), findsNothing);
  });
}
