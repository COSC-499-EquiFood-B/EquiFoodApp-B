// test to sign up test restaurant user
// we simulate signing in with a test restaurant user

import 'package:equi_food_app/register/createRestaurantUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test signing up Restaurant user', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: CreateRestaurantUserWidget(),
    ));

    // get references to the input fields and the signup Button
    Finder nameField = find.byKey(new Key("signup-name-res"));
    Finder emailField = find.byKey(new Key('signup-email-res'));
    Finder passwordField = find.byKey(new Key('signup-password-res'));
    Finder passwordConfirmField =
        find.byKey(new Key('signup-password-confirm-res'));

    Finder contactField = find.byKey(new Key('signup-contact-res'));
    Finder addressField = find.byKey(new Key('signup-address-res'));
    Finder cityField = find.byKey(new Key('signup-city-res'));
    Finder zipCodeField = find.byKey(new Key('signup-zipcode-res'));

    Finder signUpButton = find.byKey(new Key("signup-button-res"));

    // enter the fields
    // leaving the state field empty so that error occurs
    await tester.enterText(nameField, "Comida Colombiana");
    await tester.enterText(emailField, "newtestresuser@gmail.com");
    await tester.enterText(passwordField, "newtestres123");
    await tester.enterText(passwordConfirmField, "newtestres123");

    await tester.enterText(contactField, "1234567890");
    await tester.enterText(addressField, "804-32 Calle Reina");
    await tester.enterText(cityField, "Madrid");
    await tester.enterText(zipCodeField, "ESP347");
    await tester.tap(signUpButton);

    await tester.pumpAndSettle(const Duration(seconds: 10));

    // since the password and confirm password don't match,
    // a Snackbar showing the message below will pop up
    //expect(find.text('One or more fields are empty.'), findsWidgets);

    // Account won't be created,
    // so there would be no Snackabar showing the message below
    expect(find.text('Account created successfully'), findsNothing);
  });
}
