import 'package:drift/drift.dart';

import '../../speed_test/data/netqira_speed_test_engine.dart';
import 'netqira_database.dart';

abstract final class NetqiraQualityClassifier {
  static String evaluate(SpeedTestResult result) {
    if (result.downloadMbps >= 100 &&
        result.uploadMbps >= 20 &&
        result.pingMs <= 30 &&
        result.jitterMs <= 10) {
      return 'Excelente';
    }

    if (result.downloadMbps >= 25 &&
        result.uploadMbps >= 5 &&
        result.pingMs <= 60 &&
        result.jitterMs <= 20) {
      return 'Buena';
    }

    if (result.downloadMbps >= 10 &&
        result.uploadMbps >= 2 &&
        result.pingMs <= 100 &&
        result.jitterMs <= 35) {
      return 'Regular';
    }

    return 'Baja';
  }
}

class NetqiraHistoryRepository {
  NetqiraHistoryRepository(this.database);

  final NetqiraDatabase database;

  static NetqiraHistoryRepository? _instance;

  static NetqiraHistoryRepository get instance {
    return _instance ??= NetqiraHistoryRepository(NetqiraDatabase.instance);
  }

  static void useForTesting(NetqiraHistoryRepository repository) {
    _instance = repository;
  }

  static void resetForTesting() {
    _instance = null;
  }

  Future<int> save(SpeedTestResult result) {
    return database
        .into(database.speedTestHistory)
        .insert(
          SpeedTestHistoryCompanion.insert(
            serverName: result.serverName,
            pingMs: result.pingMs,
            jitterMs: result.jitterMs,
            downloadMbps: result.downloadMbps,
            uploadMbps: result.uploadMbps,
            quality: NetqiraQualityClassifier.evaluate(result),
            createdAt: DateTime.now(),
          ),
        );
  }

  Stream<List<SpeedTestRecord>> watchRecent({int limit = 100}) {
    final query = database.select(database.speedTestHistory)
      ..orderBy([(row) => OrderingTerm.desc(row.createdAt)])
      ..limit(limit);

    return query.watch();
  }

  Future<List<SpeedTestRecord>> getRecent({int limit = 100}) {
    final query = database.select(database.speedTestHistory)
      ..orderBy([(row) => OrderingTerm.desc(row.createdAt)])
      ..limit(limit);

    return query.get();
  }

  Future<int> clearAll() {
    return database.delete(database.speedTestHistory).go();
  }
}
