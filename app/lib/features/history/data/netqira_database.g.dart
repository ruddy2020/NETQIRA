// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'netqira_database.dart';

// ignore_for_file: type=lint
class $SpeedTestHistoryTable extends SpeedTestHistory
    with TableInfo<$SpeedTestHistoryTable, SpeedTestRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeedTestHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverNameMeta = const VerificationMeta(
    'serverName',
  );
  @override
  late final GeneratedColumn<String> serverName = GeneratedColumn<String>(
    'server_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pingMsMeta = const VerificationMeta('pingMs');
  @override
  late final GeneratedColumn<double> pingMs = GeneratedColumn<double>(
    'ping_ms',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jitterMsMeta = const VerificationMeta(
    'jitterMs',
  );
  @override
  late final GeneratedColumn<double> jitterMs = GeneratedColumn<double>(
    'jitter_ms',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _downloadMbpsMeta = const VerificationMeta(
    'downloadMbps',
  );
  @override
  late final GeneratedColumn<double> downloadMbps = GeneratedColumn<double>(
    'download_mbps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadMbpsMeta = const VerificationMeta(
    'uploadMbps',
  );
  @override
  late final GeneratedColumn<double> uploadMbps = GeneratedColumn<double>(
    'upload_mbps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverName,
    pingMs,
    jitterMs,
    downloadMbps,
    uploadMbps,
    quality,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'speed_test_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeedTestRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_name')) {
      context.handle(
        _serverNameMeta,
        serverName.isAcceptableOrUnknown(data['server_name']!, _serverNameMeta),
      );
    } else if (isInserting) {
      context.missing(_serverNameMeta);
    }
    if (data.containsKey('ping_ms')) {
      context.handle(
        _pingMsMeta,
        pingMs.isAcceptableOrUnknown(data['ping_ms']!, _pingMsMeta),
      );
    } else if (isInserting) {
      context.missing(_pingMsMeta);
    }
    if (data.containsKey('jitter_ms')) {
      context.handle(
        _jitterMsMeta,
        jitterMs.isAcceptableOrUnknown(data['jitter_ms']!, _jitterMsMeta),
      );
    } else if (isInserting) {
      context.missing(_jitterMsMeta);
    }
    if (data.containsKey('download_mbps')) {
      context.handle(
        _downloadMbpsMeta,
        downloadMbps.isAcceptableOrUnknown(
          data['download_mbps']!,
          _downloadMbpsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_downloadMbpsMeta);
    }
    if (data.containsKey('upload_mbps')) {
      context.handle(
        _uploadMbpsMeta,
        uploadMbps.isAcceptableOrUnknown(data['upload_mbps']!, _uploadMbpsMeta),
      );
    } else if (isInserting) {
      context.missing(_uploadMbpsMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeedTestRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeedTestRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_name'],
      )!,
      pingMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ping_ms'],
      )!,
      jitterMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}jitter_ms'],
      )!,
      downloadMbps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}download_mbps'],
      )!,
      uploadMbps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}upload_mbps'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SpeedTestHistoryTable createAlias(String alias) {
    return $SpeedTestHistoryTable(attachedDatabase, alias);
  }
}

class SpeedTestRecord extends DataClass implements Insertable<SpeedTestRecord> {
  final int id;
  final String serverName;
  final double pingMs;
  final double jitterMs;
  final double downloadMbps;
  final double uploadMbps;
  final String quality;
  final DateTime createdAt;
  const SpeedTestRecord({
    required this.id,
    required this.serverName,
    required this.pingMs,
    required this.jitterMs,
    required this.downloadMbps,
    required this.uploadMbps,
    required this.quality,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_name'] = Variable<String>(serverName);
    map['ping_ms'] = Variable<double>(pingMs);
    map['jitter_ms'] = Variable<double>(jitterMs);
    map['download_mbps'] = Variable<double>(downloadMbps);
    map['upload_mbps'] = Variable<double>(uploadMbps);
    map['quality'] = Variable<String>(quality);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SpeedTestHistoryCompanion toCompanion(bool nullToAbsent) {
    return SpeedTestHistoryCompanion(
      id: Value(id),
      serverName: Value(serverName),
      pingMs: Value(pingMs),
      jitterMs: Value(jitterMs),
      downloadMbps: Value(downloadMbps),
      uploadMbps: Value(uploadMbps),
      quality: Value(quality),
      createdAt: Value(createdAt),
    );
  }

  factory SpeedTestRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeedTestRecord(
      id: serializer.fromJson<int>(json['id']),
      serverName: serializer.fromJson<String>(json['serverName']),
      pingMs: serializer.fromJson<double>(json['pingMs']),
      jitterMs: serializer.fromJson<double>(json['jitterMs']),
      downloadMbps: serializer.fromJson<double>(json['downloadMbps']),
      uploadMbps: serializer.fromJson<double>(json['uploadMbps']),
      quality: serializer.fromJson<String>(json['quality']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverName': serializer.toJson<String>(serverName),
      'pingMs': serializer.toJson<double>(pingMs),
      'jitterMs': serializer.toJson<double>(jitterMs),
      'downloadMbps': serializer.toJson<double>(downloadMbps),
      'uploadMbps': serializer.toJson<double>(uploadMbps),
      'quality': serializer.toJson<String>(quality),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SpeedTestRecord copyWith({
    int? id,
    String? serverName,
    double? pingMs,
    double? jitterMs,
    double? downloadMbps,
    double? uploadMbps,
    String? quality,
    DateTime? createdAt,
  }) => SpeedTestRecord(
    id: id ?? this.id,
    serverName: serverName ?? this.serverName,
    pingMs: pingMs ?? this.pingMs,
    jitterMs: jitterMs ?? this.jitterMs,
    downloadMbps: downloadMbps ?? this.downloadMbps,
    uploadMbps: uploadMbps ?? this.uploadMbps,
    quality: quality ?? this.quality,
    createdAt: createdAt ?? this.createdAt,
  );
  SpeedTestRecord copyWithCompanion(SpeedTestHistoryCompanion data) {
    return SpeedTestRecord(
      id: data.id.present ? data.id.value : this.id,
      serverName: data.serverName.present
          ? data.serverName.value
          : this.serverName,
      pingMs: data.pingMs.present ? data.pingMs.value : this.pingMs,
      jitterMs: data.jitterMs.present ? data.jitterMs.value : this.jitterMs,
      downloadMbps: data.downloadMbps.present
          ? data.downloadMbps.value
          : this.downloadMbps,
      uploadMbps: data.uploadMbps.present
          ? data.uploadMbps.value
          : this.uploadMbps,
      quality: data.quality.present ? data.quality.value : this.quality,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeedTestRecord(')
          ..write('id: $id, ')
          ..write('serverName: $serverName, ')
          ..write('pingMs: $pingMs, ')
          ..write('jitterMs: $jitterMs, ')
          ..write('downloadMbps: $downloadMbps, ')
          ..write('uploadMbps: $uploadMbps, ')
          ..write('quality: $quality, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverName,
    pingMs,
    jitterMs,
    downloadMbps,
    uploadMbps,
    quality,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeedTestRecord &&
          other.id == this.id &&
          other.serverName == this.serverName &&
          other.pingMs == this.pingMs &&
          other.jitterMs == this.jitterMs &&
          other.downloadMbps == this.downloadMbps &&
          other.uploadMbps == this.uploadMbps &&
          other.quality == this.quality &&
          other.createdAt == this.createdAt);
}

class SpeedTestHistoryCompanion extends UpdateCompanion<SpeedTestRecord> {
  final Value<int> id;
  final Value<String> serverName;
  final Value<double> pingMs;
  final Value<double> jitterMs;
  final Value<double> downloadMbps;
  final Value<double> uploadMbps;
  final Value<String> quality;
  final Value<DateTime> createdAt;
  const SpeedTestHistoryCompanion({
    this.id = const Value.absent(),
    this.serverName = const Value.absent(),
    this.pingMs = const Value.absent(),
    this.jitterMs = const Value.absent(),
    this.downloadMbps = const Value.absent(),
    this.uploadMbps = const Value.absent(),
    this.quality = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SpeedTestHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String serverName,
    required double pingMs,
    required double jitterMs,
    required double downloadMbps,
    required double uploadMbps,
    required String quality,
    required DateTime createdAt,
  }) : serverName = Value(serverName),
       pingMs = Value(pingMs),
       jitterMs = Value(jitterMs),
       downloadMbps = Value(downloadMbps),
       uploadMbps = Value(uploadMbps),
       quality = Value(quality),
       createdAt = Value(createdAt);
  static Insertable<SpeedTestRecord> custom({
    Expression<int>? id,
    Expression<String>? serverName,
    Expression<double>? pingMs,
    Expression<double>? jitterMs,
    Expression<double>? downloadMbps,
    Expression<double>? uploadMbps,
    Expression<String>? quality,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverName != null) 'server_name': serverName,
      if (pingMs != null) 'ping_ms': pingMs,
      if (jitterMs != null) 'jitter_ms': jitterMs,
      if (downloadMbps != null) 'download_mbps': downloadMbps,
      if (uploadMbps != null) 'upload_mbps': uploadMbps,
      if (quality != null) 'quality': quality,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SpeedTestHistoryCompanion copyWith({
    Value<int>? id,
    Value<String>? serverName,
    Value<double>? pingMs,
    Value<double>? jitterMs,
    Value<double>? downloadMbps,
    Value<double>? uploadMbps,
    Value<String>? quality,
    Value<DateTime>? createdAt,
  }) {
    return SpeedTestHistoryCompanion(
      id: id ?? this.id,
      serverName: serverName ?? this.serverName,
      pingMs: pingMs ?? this.pingMs,
      jitterMs: jitterMs ?? this.jitterMs,
      downloadMbps: downloadMbps ?? this.downloadMbps,
      uploadMbps: uploadMbps ?? this.uploadMbps,
      quality: quality ?? this.quality,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverName.present) {
      map['server_name'] = Variable<String>(serverName.value);
    }
    if (pingMs.present) {
      map['ping_ms'] = Variable<double>(pingMs.value);
    }
    if (jitterMs.present) {
      map['jitter_ms'] = Variable<double>(jitterMs.value);
    }
    if (downloadMbps.present) {
      map['download_mbps'] = Variable<double>(downloadMbps.value);
    }
    if (uploadMbps.present) {
      map['upload_mbps'] = Variable<double>(uploadMbps.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeedTestHistoryCompanion(')
          ..write('id: $id, ')
          ..write('serverName: $serverName, ')
          ..write('pingMs: $pingMs, ')
          ..write('jitterMs: $jitterMs, ')
          ..write('downloadMbps: $downloadMbps, ')
          ..write('uploadMbps: $uploadMbps, ')
          ..write('quality: $quality, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$NetqiraDatabase extends GeneratedDatabase {
  _$NetqiraDatabase(QueryExecutor e) : super(e);
  $NetqiraDatabaseManager get managers => $NetqiraDatabaseManager(this);
  late final $SpeedTestHistoryTable speedTestHistory = $SpeedTestHistoryTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [speedTestHistory];
}

typedef $$SpeedTestHistoryTableCreateCompanionBuilder =
    SpeedTestHistoryCompanion Function({
      Value<int> id,
      required String serverName,
      required double pingMs,
      required double jitterMs,
      required double downloadMbps,
      required double uploadMbps,
      required String quality,
      required DateTime createdAt,
    });
typedef $$SpeedTestHistoryTableUpdateCompanionBuilder =
    SpeedTestHistoryCompanion Function({
      Value<int> id,
      Value<String> serverName,
      Value<double> pingMs,
      Value<double> jitterMs,
      Value<double> downloadMbps,
      Value<double> uploadMbps,
      Value<String> quality,
      Value<DateTime> createdAt,
    });

class $$SpeedTestHistoryTableFilterComposer
    extends Composer<_$NetqiraDatabase, $SpeedTestHistoryTable> {
  $$SpeedTestHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverName => $composableBuilder(
    column: $table.serverName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pingMs => $composableBuilder(
    column: $table.pingMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get jitterMs => $composableBuilder(
    column: $table.jitterMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get downloadMbps => $composableBuilder(
    column: $table.downloadMbps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uploadMbps => $composableBuilder(
    column: $table.uploadMbps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SpeedTestHistoryTableOrderingComposer
    extends Composer<_$NetqiraDatabase, $SpeedTestHistoryTable> {
  $$SpeedTestHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverName => $composableBuilder(
    column: $table.serverName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pingMs => $composableBuilder(
    column: $table.pingMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get jitterMs => $composableBuilder(
    column: $table.jitterMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get downloadMbps => $composableBuilder(
    column: $table.downloadMbps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uploadMbps => $composableBuilder(
    column: $table.uploadMbps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpeedTestHistoryTableAnnotationComposer
    extends Composer<_$NetqiraDatabase, $SpeedTestHistoryTable> {
  $$SpeedTestHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverName => $composableBuilder(
    column: $table.serverName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pingMs =>
      $composableBuilder(column: $table.pingMs, builder: (column) => column);

  GeneratedColumn<double> get jitterMs =>
      $composableBuilder(column: $table.jitterMs, builder: (column) => column);

  GeneratedColumn<double> get downloadMbps => $composableBuilder(
    column: $table.downloadMbps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get uploadMbps => $composableBuilder(
    column: $table.uploadMbps,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SpeedTestHistoryTableTableManager
    extends
        RootTableManager<
          _$NetqiraDatabase,
          $SpeedTestHistoryTable,
          SpeedTestRecord,
          $$SpeedTestHistoryTableFilterComposer,
          $$SpeedTestHistoryTableOrderingComposer,
          $$SpeedTestHistoryTableAnnotationComposer,
          $$SpeedTestHistoryTableCreateCompanionBuilder,
          $$SpeedTestHistoryTableUpdateCompanionBuilder,
          (
            SpeedTestRecord,
            BaseReferences<
              _$NetqiraDatabase,
              $SpeedTestHistoryTable,
              SpeedTestRecord
            >,
          ),
          SpeedTestRecord,
          PrefetchHooks Function()
        > {
  $$SpeedTestHistoryTableTableManager(
    _$NetqiraDatabase db,
    $SpeedTestHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeedTestHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpeedTestHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpeedTestHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverName = const Value.absent(),
                Value<double> pingMs = const Value.absent(),
                Value<double> jitterMs = const Value.absent(),
                Value<double> downloadMbps = const Value.absent(),
                Value<double> uploadMbps = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SpeedTestHistoryCompanion(
                id: id,
                serverName: serverName,
                pingMs: pingMs,
                jitterMs: jitterMs,
                downloadMbps: downloadMbps,
                uploadMbps: uploadMbps,
                quality: quality,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverName,
                required double pingMs,
                required double jitterMs,
                required double downloadMbps,
                required double uploadMbps,
                required String quality,
                required DateTime createdAt,
              }) => SpeedTestHistoryCompanion.insert(
                id: id,
                serverName: serverName,
                pingMs: pingMs,
                jitterMs: jitterMs,
                downloadMbps: downloadMbps,
                uploadMbps: uploadMbps,
                quality: quality,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpeedTestHistoryTable, SpeedTestRecord>(table),
                  BaseReferences<
                    _$NetqiraDatabase,
                    $SpeedTestHistoryTable,
                    SpeedTestRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SpeedTestHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$NetqiraDatabase,
      $SpeedTestHistoryTable,
      SpeedTestRecord,
      $$SpeedTestHistoryTableFilterComposer,
      $$SpeedTestHistoryTableOrderingComposer,
      $$SpeedTestHistoryTableAnnotationComposer,
      $$SpeedTestHistoryTableCreateCompanionBuilder,
      $$SpeedTestHistoryTableUpdateCompanionBuilder,
      (
        SpeedTestRecord,
        BaseReferences<
          _$NetqiraDatabase,
          $SpeedTestHistoryTable,
          SpeedTestRecord
        >,
      ),
      SpeedTestRecord,
      PrefetchHooks Function()
    >;

class $NetqiraDatabaseManager {
  final _$NetqiraDatabase _db;
  $NetqiraDatabaseManager(this._db);
  $$SpeedTestHistoryTableTableManager get speedTestHistory =>
      $$SpeedTestHistoryTableTableManager(_db, _db.speedTestHistory);
}
