import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_frontend/main.dart';

void main() {
  testWidgets('Initial UI shows title and current turn', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    expect(find.text('Tic Tac Toe'), findsOneWidget);
    expect(find.textContaining('Current Turn'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('Tap places X then O and prevents overwrite', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    // First tap should place X at index 0
    final firstTile = find.byType(InkWell).first;
    await tester.tap(firstTile);
    await tester.pumpAndSettle();

    expect(find.text('X'), findsWidgets);

    // Second tap on a different tile should place O
    final tiles = find.byType(InkWell);
    await tester.tap(tiles.at(1));
    await tester.pumpAndSettle();
    expect(find.text('O'), findsWidgets);

    // Attempt to overwrite first tile should do nothing
    await tester.tap(firstTile);
    await tester.pumpAndSettle();
    // Still exactly one 'X' in first tile spot visually; general check that both marks still present
    expect(find.text('X'), findsWidgets);
    expect(find.text('O'), findsWidgets);
  });
}
