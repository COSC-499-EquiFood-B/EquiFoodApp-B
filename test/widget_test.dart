

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:equi_food_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });
}
