import 'package:flutter_test/flutter_test.dart';

import '../lib/example.dart';

void main() {
  test('increment function should return the incremented value', () {
    expect(increment(2), 3);
    expect(increment(-2), -1);
    expect(increment(0), 1);
  });
}
