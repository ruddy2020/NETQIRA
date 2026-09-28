import 'package:flutter_test/flutter_test.dart';
import 'package:netqira/features/speed_test/data/netqira_speed_test_engine.dart';

void main() {
  group('SpeedTestMath', () {
    test('calcula promedio', () {
      expect(SpeedTestMath.average([10, 20, 30]), 20);
    });

    test('calcula jitter como diferencia media entre muestras', () {
      expect(SpeedTestMath.jitter([10, 14, 11, 15]), closeTo(11 / 3, 0.001));
    });

    test('convierte bytes y tiempo a Mbps', () {
      final value = SpeedTestMath.mbps(1000000, const Duration(seconds: 1));
      expect(value, closeTo(8, 0.001));
    });
  });
}
