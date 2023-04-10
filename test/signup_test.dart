import 'package:equi_food_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:equi_food_app/index.dart';
import 'package:equi_food_app/register/createUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Finds the login Button in the login widget',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupWidget(),
    ));

    await tester.pumpAndSettle(const Duration(seconds: 5));
    // verify that our counter starts at 0
    expect(find.widgetWithText(FFButtonWidget, 'Sign Up'), findsWidgets);
    expect(find.widgetWithText(FFButtonWidget, 'Login'), findsNothing);
  });
}
