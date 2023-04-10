// test to login test user
// we simulate logging in with a test user

import 'package:equi_food_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test logging in user', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginWidget(),
    ));

    // get references to the email, password fields and the login Button
    Finder emailField = find.byKey(new Key('login-email'));
    Finder passwordField = find.byKey(new Key('login-password'));
    Finder loginButton = find.byKey(new Key("login-button"));

    // enter email and password
    await tester.enterText(emailField, "user1@gmail.com");
    await tester.enterText(passwordField, "");
    await tester.tap(loginButton);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    // since one of the fields is empty,
    // a Snackbar showing the message below will pop up
    expect(find.text('Please fill up text boxes.'), findsWidgets);
  });
}
