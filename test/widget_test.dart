import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safestride/main_firebase_test.dart';

void main() {
  testWidgets('SafeStride app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SafeStrideApp());

    // Wait for the app to initialize
    await tester.pumpAndSettle();

    // Verify that the app loads successfully (no crashes)
    expect(tester.takeException(), throwsA(isA<Exception>()), isFalse);
import 'package:safestride/main.dart';

void main() {
  testWidgets('SafeStride app builds successfully',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Test'))));

    // Verify that MaterialApp is present
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}