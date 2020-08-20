// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/main.dart';

void main() {
  testWidgets('click shows launch icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byIcon(Icons.launch), findsNothing);

    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle(); // to test animation beforehand pumpAndSettle, wait for all events to finish. otherwise use .pump()

    expect(find.byIcon(Icons.launch), findsOneWidget);
  });
}
  