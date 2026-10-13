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
import 'activity_kind.dart' as _ig63m04h;

/// Live activity feed shown on the organizer dashboard.
abstract class ActivityLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ActivityLog._({
    this.id,
    required this.eventId,
    required this.kind,
    required this.message,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ActivityLog({
    int? id,
    required int eventId,
    required _ig63m04h.ActivityKind kind,
    required String message,
    DateTime? createdAt,
  }) = _ActivityLogImpl;

  factory ActivityLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityLog(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      kind: _ig63m04h.ActivityKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ActivityLogTable();

  static const db = ActivityLogRepository._();

  @override
  int? id;

  int eventId;

  _ig63m04h.ActivityKind kind;

  String message;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ActivityLog copyWith({
    int? id,
    int? eventId,
    _ig63m04h.ActivityKind? kind,
    String? message,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityLog',
      if (id != null) 'id': id,
      'eventId': eventId,
      'kind': kind.toJson(),
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityLog',
      if (id != null) 'id': id,
      'eventId': eventId,
      'kind': kind.toJson(),
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  static ActivityLogInclude include() {
    return ActivityLogInclude._();
  }

  static ActivityLogIncludeList includeList({
    _is.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityLogTable>? orderBy,
    _is.OrderByListBuilder<ActivityLogTable>? orderByList,
    ActivityLogInclude? include,
  }) {
    return ActivityLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityLogImpl extends ActivityLog {
  _ActivityLogImpl({
    int? id,
    required int eventId,
    required _ig63m04h.ActivityKind kind,
    required String message,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         kind: kind,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ActivityLog copyWith({
    Object? id = _Undefined,
    int? eventId,
    _ig63m04h.ActivityKind? kind,
    String? message,
    DateTime? createdAt,
  }) {
    return ActivityLog(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      kind: kind ?? this.kind,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ActivityLogUpdateTable extends _is.UpdateTable<ActivityLogTable> {
  ActivityLogUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<_ig63m04h.ActivityKind, _ig63m04h.ActivityKind> kind(
    _ig63m04h.ActivityKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ActivityLogTable extends _is.Table<int?> {
  ActivityLogTable({super.tableRelation}) : super(tableName: 'activity_log') {
    updateTable = ActivityLogUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ActivityLogUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnEnum<_ig63m04h.ActivityKind> kind;

  late final _is.ColumnString message;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    kind,
    message,
    createdAt,
  ];
}

class ActivityLogInclude extends _is.IncludeObject {
  ActivityLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ActivityLog.t;
}

class ActivityLogIncludeList extends _is.IncludeList {
  ActivityLogIncludeList._({
    _is.WhereExpressionBuilder<ActivityLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActivityLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ActivityLog.t;
}

class ActivityLogRepository {
  const ActivityLogRepository._();

  /// Returns a list of [ActivityLog]s matching the given query parameters.
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
  Future<List<ActivityLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityLogTable>? orderBy,
    _is.OrderByListBuilder<ActivityLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ActivityLog>(
      where: where?.call(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ActivityLog] matching the given query parameters.
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
  Future<ActivityLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityLogTable>? where,
    int? offset,
    _is.OrderByBuilder<ActivityLogTable>? orderBy,
    _is.OrderByListBuilder<ActivityLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ActivityLog>(
      where: where?.call(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ActivityLog] by its [id] or null if no such row exists.
  Future<ActivityLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ActivityLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ActivityLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ActivityLog]s will have their `id` fields set.
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
  Future<List<ActivityLog>> insert(
    _is.DatabaseSession session,
    List<ActivityLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ActivityLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ActivityLog] and returns the inserted row.
  ///
  /// The returned [ActivityLog] will have its `id` field set.
  Future<ActivityLog> insertRow(
    _is.DatabaseSession session,
    ActivityLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActivityLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ActivityLog]s in the list and returns the resulting rows.
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
  /// The returned [ActivityLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityLog>> upsert(
    _is.DatabaseSession session,
    List<ActivityLog> rows, {
    required _is.ColumnSelections<ActivityLogTable> conflictColumns,
    _is.ColumnSelections<ActivityLogTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ActivityLog>(
      rows,
      conflictColumns: conflictColumns(ActivityLog.t),
      updateColumns: updateColumns?.call(ActivityLog.t),
      updateWhere: updateWhere?.call(ActivityLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ActivityLog] and returns the resulting row.
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
  /// The returned [ActivityLog] will have its `id` field set.
  Future<ActivityLog?> upsertRow(
    _is.DatabaseSession session,
    ActivityLog row, {
    required _is.ColumnSelections<ActivityLogTable> conflictColumns,
    _is.ColumnSelections<ActivityLogTable>? updateColumns,
    _is.WhereExpressionBuilder<ActivityLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ActivityLog>(
      row,
      conflictColumns: conflictColumns(ActivityLog.t),
      updateColumns: updateColumns?.call(ActivityLog.t),
      updateWhere: updateWhere?.call(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityLog>> update(
    _is.DatabaseSession session,
    List<ActivityLog> rows, {
    _is.ColumnSelections<ActivityLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ActivityLog>(
      rows,
      columns: columns?.call(ActivityLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ActivityLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActivityLog> updateRow(
    _is.DatabaseSession session,
    ActivityLog row, {
    _is.ColumnSelections<ActivityLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActivityLog>(
      row,
      columns: columns?.call(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ActivityLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ActivityLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ActivityLog>(
      id,
      columnValues: columnValues(ActivityLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ActivityLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ActivityLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ActivityLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ActivityLogTable>? orderBy,
    _is.OrderByListBuilder<ActivityLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ActivityLog>(
      columnValues: columnValues(ActivityLog.t.updateTable),
      where: where(ActivityLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ActivityLog]s in the list and returns the deleted rows.
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
  Future<List<ActivityLog>> delete(
    _is.DatabaseSession session,
    List<ActivityLog> rows, {
    _is.OrderByBuilder<ActivityLogTable>? orderBy,
    _is.OrderByListBuilder<ActivityLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ActivityLog>(
      rows,
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ActivityLog].
  Future<ActivityLog> deleteRow(
    _is.DatabaseSession session,
    ActivityLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActivityLog>(
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
  Future<List<ActivityLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityLogTable> where,
    _is.OrderByBuilder<ActivityLogTable>? orderBy,
    _is.OrderByListBuilder<ActivityLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ActivityLog>(
      where: where(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ActivityLog>(
      where: where?.call(ActivityLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ActivityLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ActivityLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ActivityLog>(
      where: where(ActivityLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
