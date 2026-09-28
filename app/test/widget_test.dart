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
}
