import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firstapp/main.dart';

void main() {
  testWidgets('Shop calculation smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Calculate Total'), findsOneWidget);
    expect(find.text('Calculate Change'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '50');
    await tester.enterText(find.byType(TextField).at(1), '3');
    await tester.tap(find.text('Calculate Total'));
    await tester.pump();

    expect(find.text('total : 150.0 Baht'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(2), '200');
    await tester.tap(find.text('Calculate Change'));
    await tester.pump();

    expect(find.text('Change : 50.0 Baht'), findsOneWidget);
  });
}
