import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:denio_imagine/shared/widgets/app_widgets.dart';

void main() {
  testWidgets('DenioLogo renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: DenioLogo(size: 60),
      ),
    ));

    // Check if the logo text 'D' and 'i' are present
    expect(find.text('D'), findsOneWidget);
    expect(find.text('i'), findsOneWidget);
  });
}
