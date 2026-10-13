/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// A project's posterior after a vote, for the convergence chart.
abstract class ScoreSnapshot
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ScoreSnapshot._({
    this.id,
    required this.eventId,
    required this.projectId,
    required this.mu,
    required this.sigmaSq,
    required this.voteNumber,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ScoreSnapshot({
    int? id,
    required int eventId,
    required int projectId,
    required double mu,
    required double sigmaSq,
    required int voteNumber,
    DateTime? createdAt,
  }) = _ScoreSnapshotImpl;

  factory ScoreSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScoreSnapshot(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      mu: (jsonSerialization['mu'] as num).toDouble(),
      sigmaSq: (jsonSerialization['sigmaSq'] as num).toDouble(),
      voteNumber: jsonSerialization['voteNumber'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ScoreSnapshotTable();

  static const db = ScoreSnapshotRepository._();

  @override
  int? id;

  int eventId;

  int projectId;

  double mu;

  double sigmaSq;

  /// Total number of votes in the event when the snapshot was taken.
  int voteNumber;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScoreSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ScoreSnapshot copyWith({
    int? id,
    int? eventId,
    int? projectId,
    double? mu,
    double? sigmaSq,
    int? voteNumber,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScoreSnapshot',
      if (id != null) 'id': id,
      'eventId': eventId,
      'projectId': projectId,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'voteNumber': voteNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScoreSnapshot',
      if (id != null) 'id': id,
      'eventId': eventId,
      'projectId': projectId,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'voteNumber': voteNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  static ScoreSnapshotInclude include() {
    return ScoreSnapshotInclude._();
  }

  static ScoreSnapshotIncludeList includeList({
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScoreSnapshotTable>? orderBy,
    _is.OrderByListBuilder<ScoreSnapshotTable>? orderByList,
    ScoreSnapshotInclude? include,
  }) {
    return ScoreSnapshotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScoreSnapshot.t),
      orderByList: orderByList?.call(ScoreSnapshot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScoreSnapshotImpl extends ScoreSnapshot {
  _ScoreSnapshotImpl({
    int? id,
    required int eventId,
    required int projectId,
    required double mu,
    required double sigmaSq,
    required int voteNumber,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         projectId: projectId,
         mu: mu,
         sigmaSq: sigmaSq,
         voteNumber: voteNumber,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ScoreSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ScoreSnapshot copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? projectId,
    double? mu,
    double? sigmaSq,
    int? voteNumber,
    DateTime? createdAt,
  }) {
    return ScoreSnapshot(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      projectId: projectId ?? this.projectId,
      mu: mu ?? this.mu,
      sigmaSq: sigmaSq ?? this.sigmaSq,
      voteNumber: voteNumber ?? this.voteNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ScoreSnapshotUpdateTable extends _is.UpdateTable<ScoreSnapshotTable> {
  ScoreSnapshotUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<double, double> mu(double value) => _is.ColumnValue(
    table.mu,
    value,
  );

  _is.ColumnValue<double, double> sigmaSq(double value) => _is.ColumnValue(
    table.sigmaSq,
    value,
  );

  _is.ColumnValue<int, int> voteNumber(int value) => _is.ColumnValue(
    table.voteNumber,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ScoreSnapshotTable extends _is.Table<int?> {
  ScoreSnapshotTable({super.tableRelation})
    : super(tableName: 'score_snapshot') {
    updateTable = ScoreSnapshotUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    mu = _is.ColumnDouble(
      'mu',
      this,
    );
    sigmaSq = _is.ColumnDouble(
      'sigmaSq',
      this,
    );
    voteNumber = _is.ColumnInt(
      'voteNumber',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ScoreSnapshotUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnInt projectId;

  late final _is.ColumnDouble mu;

  late final _is.ColumnDouble sigmaSq;

  /// Total number of votes in the event when the snapshot was taken.
  late final _is.ColumnInt voteNumber;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    projectId,
    mu,
    sigmaSq,
    voteNumber,
    createdAt,
  ];
}

class ScoreSnapshotInclude extends _is.IncludeObject {
  ScoreSnapshotInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ScoreSnapshot.t;
}

class ScoreSnapshotIncludeList extends _is.IncludeList {
  ScoreSnapshotIncludeList._({
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScoreSnapshot.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ScoreSnapshot.t;
}

class ScoreSnapshotRepository {
  const ScoreSnapshotRepository._();

  /// Returns a list of [ScoreSnapshot]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ScoreSnapshot>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScoreSnapshotTable>? orderBy,
    _is.OrderByListBuilder<ScoreSnapshotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScoreSnapshot>(
      where: where?.call(ScoreSnapshot.t),
      orderBy: orderBy?.call(ScoreSnapshot.t),
      orderByList: orderByList?.call(ScoreSnapshot.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScoreSnapshot] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ScoreSnapshot?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? where,
    int? offset,
    _is.OrderByBuilder<ScoreSnapshotTable>? orderBy,
    _is.OrderByListBuilder<ScoreSnapshotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScoreSnapshot>(
      where: where?.call(ScoreSnapshot.t),
      orderBy: orderBy?.call(ScoreSnapshot.t),
      orderByList: orderByList?.call(ScoreSnapshot.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScoreSnapshot] by its [id] or null if no such row exists.
  Future<ScoreSnapshot?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScoreSnapshot>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScoreSnapshot]s in the list and returns the inserted rows.
  ///
  /// The returned [ScoreSnapshot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScoreSnapshot>> insert(
    _is.DatabaseSession session,
    List<ScoreSnapshot> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ScoreSnapshot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ScoreSnapshot] and returns the inserted row.
  ///
  /// The returned [ScoreSnapshot] will have its `id` field set.
  Future<ScoreSnapshot> insertRow(
    _is.DatabaseSession session,
    ScoreSnapshot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScoreSnapshot>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ScoreSnapshot]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ScoreSnapshot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScoreSnapshot>> upsert(
    _is.DatabaseSession session,
    List<ScoreSnapshot> rows, {
    required _is.ColumnSelections<ScoreSnapshotTable> conflictColumns,
    _is.ColumnSelections<ScoreSnapshotTable>? updateColumns,
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ScoreSnapshot>(
      rows,
      conflictColumns: conflictColumns(ScoreSnapshot.t),
      updateColumns: updateColumns?.call(ScoreSnapshot.t),
      updateWhere: updateWhere?.call(ScoreSnapshot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ScoreSnapshot] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ScoreSnapshot] will have its `id` field set.
  Future<ScoreSnapshot?> upsertRow(
    _is.DatabaseSession session,
    ScoreSnapshot row, {
    required _is.ColumnSelections<ScoreSnapshotTable> conflictColumns,
    _is.ColumnSelections<ScoreSnapshotTable>? updateColumns,
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ScoreSnapshot>(
      row,
      conflictColumns: conflictColumns(ScoreSnapshot.t),
      updateColumns: updateColumns?.call(ScoreSnapshot.t),
      updateWhere: updateWhere?.call(ScoreSnapshot.t),
      transaction: transaction,
    );
  }

  /// Updates all [ScoreSnapshot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScoreSnapshot>> update(
    _is.DatabaseSession session,
    List<ScoreSnapshot> rows, {
    _is.ColumnSelections<ScoreSnapshotTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ScoreSnapshot>(
      rows,
      columns: columns?.call(ScoreSnapshot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ScoreSnapshot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScoreSnapshot> updateRow(
    _is.DatabaseSession session,
    ScoreSnapshot row, {
    _is.ColumnSelections<ScoreSnapshotTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScoreSnapshot>(
      row,
      columns: columns?.call(ScoreSnapshot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScoreSnapshot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScoreSnapshot?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ScoreSnapshotUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ScoreSnapshot>(
      id,
      columnValues: columnValues(ScoreSnapshot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScoreSnapshot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScoreSnapshot>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ScoreSnapshotUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ScoreSnapshotTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScoreSnapshotTable>? orderBy,
    _is.OrderByListBuilder<ScoreSnapshotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ScoreSnapshot>(
      columnValues: columnValues(ScoreSnapshot.t.updateTable),
      where: where(ScoreSnapshot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScoreSnapshot.t),
      orderByList: orderByList?.call(ScoreSnapshot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ScoreSnapshot]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScoreSnapshot>> delete(
    _is.DatabaseSession session,
    List<ScoreSnapshot> rows, {
    _is.OrderByBuilder<ScoreSnapshotTable>? orderBy,
    _is.OrderByListBuilder<ScoreSnapshotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ScoreSnapshot>(
      rows,
      orderBy: orderBy?.call(ScoreSnapshot.t),
      orderByList: orderByList?.call(ScoreSnapshot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ScoreSnapshot].
  Future<ScoreSnapshot> deleteRow(
    _is.DatabaseSession session,
    ScoreSnapshot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScoreSnapshot>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScoreSnapshot>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ScoreSnapshotTable> where,
    _is.OrderByBuilder<ScoreSnapshotTable>? orderBy,
    _is.OrderByListBuilder<ScoreSnapshotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ScoreSnapshot>(
      where: where(ScoreSnapshot.t),
      orderBy: orderBy?.call(ScoreSnapshot.t),
      orderByList: orderByList?.call(ScoreSnapshot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScoreSnapshotTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ScoreSnapshot>(
      where: where?.call(ScoreSnapshot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScoreSnapshot] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ScoreSnapshotTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScoreSnapshot>(
      where: where(ScoreSnapshot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
