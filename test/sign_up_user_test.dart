// test to sign up test user
// we simulate signing in with a test user

import 'package:equi_food_app/register/createUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test signing up user', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupWidget(),
    ));

    // get references to the input fields and the signup Button
    Finder nameField = find.byKey(new Key("signup-name"));
    Finder emailField = find.byKey(new Key('signup-email'));
    Finder passwordField = find.byKey(new Key('signup-password'));
    Finder passwordConfirmField =
        find.byKey(new Key('signup-password-confirm'));
    Finder signUpButton = find.byKey(new Key("signup-button"));

    // enter the fields
    await tester.enterText(nameField, "Jose");
    await tester.enterText(emailField, "newtestuser@gmail.com");
    await tester.enterText(passwordField, "newtestuser123");
    await tester.enterText(passwordConfirmField,
        "newtestuser1234"); // keeping this different on purpose
    await tester.tap(signUpButton);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    // since the password and confirm password don't match,
    // a Snackbar showing the message below will pop up
    expect(find.text('The passwords do not match.'), findsWidgets);

    // Account won't be created,
    // so there would be no Snackabar showing the message below
    expect(find.text('Account created successfully'), findsNothing);
  });
}
