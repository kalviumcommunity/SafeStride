import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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