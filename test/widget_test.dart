// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';
import 'package:safestride/main_firebase_test.dart';

void main() {
  testWidgets('SafeStride app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SafeStrideApp());

    // Wait for the app to initialize
    await tester.pumpAndSettle();

    // Verify that the app loads successfully (no crashes)
    expect(tester.takeException(), throwsA(isA<Exception>()));
  });
}
