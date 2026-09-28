import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netqira/features/history/data/netqira_database.dart';
import 'package:netqira/features/history/data/netqira_history_repository.dart';
import 'package:netqira/features/speed_test/data/netqira_speed_test_engine.dart';

void main() {
  late NetqiraDatabase database;
  late NetqiraHistoryRepository repository;

  setUp(() {
    database = NetqiraDatabase(NativeDatabase.memory());
    repository = NetqiraHistoryRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('guarda y recupera una prueba real de velocidad', () async {
    const result = SpeedTestResult(
      serverName: 'Servidor Test',
      pingMs: 18,
      jitterMs: 4,
      downloadMbps: 145,
      uploadMbps: 28,
    );

    await repository.save(result);

    final records = await repository.getRecent();

    expect(records.length, 1);
    expect(records.first.serverName, 'Servidor Test');
    expect(records.first.downloadMbps, 145);
    expect(records.first.uploadMbps, 28);
    expect(records.first.pingMs, 18);
    expect(records.first.jitterMs, 4);
    expect(records.first.quality, 'Excelente');
  });

  test('clasifica conexion lenta como Baja', () {
    const result = SpeedTestResult(
      serverName: 'Servidor Test',
      pingMs: 150,
      jitterMs: 50,
      downloadMbps: 4,
      uploadMbps: 1,
    );

    expect(NetqiraQualityClassifier.evaluate(result), 'Baja');
  });
}
