// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dcg/main.dart';

void main() {
  testWidgets('DCG app smoke test', (WidgetTester tester) async {
    // Setup mock shared preferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(DCGApp(prefs: prefs));

    // Verify that our welcome screen loads
    expect(find.text('DCG'), findsOneWidget);
    expect(find.text('Daffodil CrisisGuard'), findsOneWidget);
    expect(find.text('Stay Alert, Stay Safe'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
