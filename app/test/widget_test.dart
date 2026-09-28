import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netqira/main.dart';

void main() {
  testWidgets('NETQIRA muestra su Home', (tester) async {
    await tester.pumpWidget(const NetqiraApp());
    await tester.pumpAndSettle();

    expect(find.text('NETQIRA'), findsOneWidget);
    expect(find.text('Prueba tu Internet'), findsOneWidget);
    expect(find.text('Iniciar prueba'), findsOneWidget);
  });

  testWidgets('Speed Test abre sin datos simulados', (tester) async {
    await tester.pumpWidget(const NetqiraApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Iniciar prueba'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Prueba de Internet'), findsOneWidget);
    expect(find.text('Preparar medición'), findsOneWidget);
    expect(find.text('--'), findsWidgets);
    expect(find.byIcon(Icons.speed_rounded), findsWidgets);
  });
}
