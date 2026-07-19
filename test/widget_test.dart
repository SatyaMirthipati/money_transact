import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_transact/ui/widgets/custom_card.dart';
import 'package:money_transact/ui/widgets/navbar_button.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('NavbarButton', () {
    testWidgets('renders its child and fires onPressed when tapped',
        (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _wrap(
          NavbarButton(
            onPressed: () => taps++,
            child: const Text('Submit'),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      expect(taps, 1);
    });

    testWidgets('uses the provided color for its container', (tester) async {
      await tester.pumpWidget(
        _wrap(
          NavbarButton(
            onPressed: () {},
            color: Colors.red,
            child: const Text('Go'),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(Container),
        ),
      );
      expect(container.color, Colors.red);
    });
  });

  group('CustomCard', () {
    testWidgets('renders its child inside a Card', (tester) async {
      await tester.pumpWidget(
        _wrap(const CustomCard(child: Text('Balance'))),
      );

      expect(find.text('Balance'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });
  });
}
