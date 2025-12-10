import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_frontend/main.dart';

void main() {
  testWidgets('Shows Tic Tac Toe title and current player status', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());

    expect(find.text('Tic Tac Toe'), findsOneWidget);
    expect(find.byKey(const Key('current_player')), findsOneWidget);
  });

  testWidgets('Grid has 9 tappable cells and restart button exists', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());
    await tester.pumpAndSettle();

    // 9 grid tiles by keys grid_0_0 to grid_2_2
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        expect(find.byKey(Key('grid_${r}_$c')), findsOneWidget);
      }
    }

    expect(find.byKey(const Key('restart_button')), findsOneWidget);
  });

  testWidgets('Tapping alternates X and O and stops after win', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());
    await tester.pumpAndSettle();

    // Simulate a quick win for X: (0,0), (1,0), (0,1), (1,1), (0,2)
    await tester.tap(find.byKey(const Key('grid_0_0')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('grid_1_0')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('grid_0_1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('grid_1_1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('grid_0_2')));
    await tester.pumpAndSettle();

    // Now game should show Winner: X
    expect(find.textContaining('Winner: X'), findsOneWidget);

    // Further taps should have no effect; try tapping an empty cell (2,2)
    await tester.tap(find.byKey(const Key('grid_2_2')));
    await tester.pumpAndSettle();

    // Status still shows Winner: X
    expect(find.textContaining('Winner: X'), findsOneWidget);
  });
}
