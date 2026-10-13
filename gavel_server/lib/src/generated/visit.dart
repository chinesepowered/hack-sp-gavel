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
import 'skip_reason.dart' as _ixl9rmv8;
import 'visit_outcome.dart' as _iici1ivk;

/// A project a judge has already been sent to (judged or skipped), so it is
/// never assigned to them again.
abstract class Visit implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Visit._({
    this.id,
    required this.eventId,
    required this.judgeId,
    required this.projectId,
    required this.outcome,
    this.skipReason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Visit({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required _iici1ivk.VisitOutcome outcome,
    _ixl9rmv8.SkipReason? skipReason,
    DateTime? createdAt,
  }) = _VisitImpl;

  factory Visit.fromJson(Map<String, dynamic> jsonSerialization) {
    return Visit(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      judgeId: jsonSerialization['judgeId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      outcome: _iici1ivk.VisitOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      skipReason: jsonSerialization['skipReason'] == null
          ? null
          : _ixl9rmv8.SkipReason.fromJson(
              (jsonSerialization['skipReason'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = VisitTable();

  static const db = VisitRepository._();

  @override
  int? id;

  int eventId;

  int judgeId;

  int projectId;

  _iici1ivk.VisitOutcome outcome;

  _ixl9rmv8.SkipReason? skipReason;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Visit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Visit copyWith({
    int? id,
    int? eventId,
    int? judgeId,
    int? projectId,
    _iici1ivk.VisitOutcome? outcome,
    _ixl9rmv8.SkipReason? skipReason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Visit',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'outcome': outcome.toJson(),
      if (skipReason != null) 'skipReason': skipReason?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Visit',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'outcome': outcome.toJson(),
      if (skipReason != null) 'skipReason': skipReason?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static VisitInclude include() {
    return VisitInclude._();
  }

  static VisitIncludeList includeList({
    _is.WhereExpressionBuilder<VisitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VisitTable>? orderBy,
    _is.OrderByListBuilder<VisitTable>? orderByList,
    VisitInclude? include,
  }) {
    return VisitIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Visit.t),
      orderByList: orderByList?.call(Visit.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VisitImpl extends Visit {
  _VisitImpl({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required _iici1ivk.VisitOutcome outcome,
    _ixl9rmv8.SkipReason? skipReason,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         judgeId: judgeId,
         projectId: projectId,
         outcome: outcome,
         skipReason: skipReason,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Visit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Visit copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? judgeId,
    int? projectId,
    _iici1ivk.VisitOutcome? outcome,
    Object? skipReason = _Undefined,
    DateTime? createdAt,
  }) {
    return Visit(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      judgeId: judgeId ?? this.judgeId,
      projectId: projectId ?? this.projectId,
      outcome: outcome ?? this.outcome,
      skipReason: skipReason is _ixl9rmv8.SkipReason?
          ? skipReason
          : this.skipReason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VisitUpdateTable extends _is.UpdateTable<VisitTable> {
  VisitUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<int, int> judgeId(int value) => _is.ColumnValue(
    table.judgeId,
    value,
  );

  _is.ColumnValue<int, int> projectId(int value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<_iici1ivk.VisitOutcome, _iici1ivk.VisitOutcome> outcome(
    _iici1ivk.VisitOutcome value,
  ) => _is.ColumnValue(
    table.outcome,
    value,
  );

  _is.ColumnValue<_ixl9rmv8.SkipReason, _ixl9rmv8.SkipReason> skipReason(
    _ixl9rmv8.SkipReason? value,
  ) => _is.ColumnValue(
    table.skipReason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class VisitTable extends _is.Table<int?> {
  VisitTable({super.tableRelation}) : super(tableName: 'visit') {
    updateTable = VisitUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    judgeId = _is.ColumnInt(
      'judgeId',
      this,
    );
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    outcome = _is.ColumnEnum(
      'outcome',
      this,
      _is.EnumSerialization.byName,
    );
    skipReason = _is.ColumnEnum(
      'skipReason',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final VisitUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnInt judgeId;

  late final _is.ColumnInt projectId;

  late final _is.ColumnEnum<_iici1ivk.VisitOutcome> outcome;

  late final _is.ColumnEnum<_ixl9rmv8.SkipReason> skipReason;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    judgeId,
    projectId,
    outcome,
    skipReason,
    createdAt,
  ];
}

class VisitInclude extends _is.IncludeObject {
  VisitInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Visit.t;
}

class VisitIncludeList extends _is.IncludeList {
  VisitIncludeList._({
    _is.WhereExpressionBuilder<VisitTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Visit.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Visit.t;
}

class VisitRepository {
  const VisitRepository._();

  /// Returns a list of [Visit]s matching the given query parameters.
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
  Future<List<Visit>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VisitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VisitTable>? orderBy,
    _is.OrderByListBuilder<VisitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Visit>(
      where: where?.call(Visit.t),
      orderBy: orderBy?.call(Visit.t),
      orderByList: orderByList?.call(Visit.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Visit] matching the given query parameters.
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
  Future<Visit?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VisitTable>? where,
    int? offset,
    _is.OrderByBuilder<VisitTable>? orderBy,
    _is.OrderByListBuilder<VisitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Visit>(
      where: where?.call(Visit.t),
      orderBy: orderBy?.call(Visit.t),
      orderByList: orderByList?.call(Visit.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Visit] by its [id] or null if no such row exists.
  Future<Visit?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Visit>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Visit]s in the list and returns the inserted rows.
  ///
  /// The returned [Visit]s will have their `id` fields set.
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
  Future<List<Visit>> insert(
    _is.DatabaseSession session,
    List<Visit> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Visit>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Visit] and returns the inserted row.
  ///
  /// The returned [Visit] will have its `id` field set.
  Future<Visit> insertRow(
    _is.DatabaseSession session,
    Visit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Visit>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Visit]s in the list and returns the resulting rows.
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
  /// The returned [Visit]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Visit>> upsert(
    _is.DatabaseSession session,
    List<Visit> rows, {
    required _is.ColumnSelections<VisitTable> conflictColumns,
    _is.ColumnSelections<VisitTable>? updateColumns,
    _is.WhereExpressionBuilder<VisitTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Visit>(
      rows,
      conflictColumns: conflictColumns(Visit.t),
      updateColumns: updateColumns?.call(Visit.t),
      updateWhere: updateWhere?.call(Visit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Visit] and returns the resulting row.
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
  /// The returned [Visit] will have its `id` field set.
  Future<Visit?> upsertRow(
    _is.DatabaseSession session,
    Visit row, {
    required _is.ColumnSelections<VisitTable> conflictColumns,
    _is.ColumnSelections<VisitTable>? updateColumns,
    _is.WhereExpressionBuilder<VisitTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Visit>(
      row,
      conflictColumns: conflictColumns(Visit.t),
      updateColumns: updateColumns?.call(Visit.t),
      updateWhere: updateWhere?.call(Visit.t),
      transaction: transaction,
    );
  }

  /// Updates all [Visit]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Visit>> update(
    _is.DatabaseSession session,
    List<Visit> rows, {
    _is.ColumnSelections<VisitTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Visit>(
      rows,
      columns: columns?.call(Visit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Visit]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Visit> updateRow(
    _is.DatabaseSession session,
    Visit row, {
    _is.ColumnSelections<VisitTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Visit>(
      row,
      columns: columns?.call(Visit.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Visit] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Visit?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VisitUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Visit>(
      id,
      columnValues: columnValues(Visit.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Visit]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Visit>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VisitUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VisitTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VisitTable>? orderBy,
    _is.OrderByListBuilder<VisitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Visit>(
      columnValues: columnValues(Visit.t.updateTable),
      where: where(Visit.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Visit.t),
      orderByList: orderByList?.call(Visit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Visit]s in the list and returns the deleted rows.
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
  Future<List<Visit>> delete(
    _is.DatabaseSession session,
    List<Visit> rows, {
    _is.OrderByBuilder<VisitTable>? orderBy,
    _is.OrderByListBuilder<VisitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Visit>(
      rows,
      orderBy: orderBy?.call(Visit.t),
      orderByList: orderByList?.call(Visit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Visit].
  Future<Visit> deleteRow(
    _is.DatabaseSession session,
    Visit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Visit>(
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
  Future<List<Visit>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VisitTable> where,
    _is.OrderByBuilder<VisitTable>? orderBy,
    _is.OrderByListBuilder<VisitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Visit>(
      where: where(Visit.t),
      orderBy: orderBy?.call(Visit.t),
      orderByList: orderByList?.call(Visit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VisitTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Visit>(
      where: where?.call(Visit.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Visit] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VisitTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Visit>(
      where: where(Visit.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
