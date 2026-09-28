import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'netqira_database.g.dart';

@DataClassName('SpeedTestRecord')
class SpeedTestHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverName => text()();
  RealColumn get pingMs => real()();
  RealColumn get jitterMs => real()();
  RealColumn get downloadMbps => real()();
  RealColumn get uploadMbps => real()();
  TextColumn get quality => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [SpeedTestHistory])
class NetqiraDatabase extends _$NetqiraDatabase {
  NetqiraDatabase(super.executor);

  NetqiraDatabase.defaults()
    : super(
        driftDatabase(
          name: 'netqira_history',
          native: const DriftNativeOptions(shareAcrossIsolates: true),
        ),
      );

  static final NetqiraDatabase instance = NetqiraDatabase.defaults();

  @override
  int get schemaVersion => 1;
}
