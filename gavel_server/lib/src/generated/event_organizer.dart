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

/// Additional organizers who claimed an event through its admin link.
abstract class EventOrganizer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EventOrganizer._({
    this.id,
    required this.eventId,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EventOrganizer({
    int? id,
    required int eventId,
    required _is.UuidValue userId,
    DateTime? createdAt,
  }) = _EventOrganizerImpl;

  factory EventOrganizer.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventOrganizer(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EventOrganizerTable();

  static const db = EventOrganizerRepository._();

  @override
  int? id;

  int eventId;

  _is.UuidValue userId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EventOrganizer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventOrganizer copyWith({
    int? id,
    int? eventId,
    _is.UuidValue? userId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventOrganizer',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventOrganizer',
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static EventOrganizerInclude include() {
    return EventOrganizerInclude._();
  }

  static EventOrganizerIncludeList includeList({
    _is.WhereExpressionBuilder<EventOrganizerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventOrganizerTable>? orderBy,
    _is.OrderByListBuilder<EventOrganizerTable>? orderByList,
    EventOrganizerInclude? include,
  }) {
    return EventOrganizerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventOrganizer.t),
      orderByList: orderByList?.call(EventOrganizer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventOrganizerImpl extends EventOrganizer {
  _EventOrganizerImpl({
    int? id,
    required int eventId,
    required _is.UuidValue userId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         userId: userId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventOrganizer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventOrganizer copyWith({
    Object? id = _Undefined,
    int? eventId,
    _is.UuidValue? userId,
    DateTime? createdAt,
  }) {
    return EventOrganizer(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EventOrganizerUpdateTable extends _is.UpdateTable<EventOrganizerTable> {
  EventOrganizerUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class EventOrganizerTable extends _is.Table<int?> {
  EventOrganizerTable({super.tableRelation})
    : super(tableName: 'event_organizer') {
    updateTable = EventOrganizerUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final EventOrganizerUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnUuid userId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    userId,
    createdAt,
  ];
}

class EventOrganizerInclude extends _is.IncludeObject {
  EventOrganizerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EventOrganizer.t;
}

class EventOrganizerIncludeList extends _is.IncludeList {
  EventOrganizerIncludeList._({
    _is.WhereExpressionBuilder<EventOrganizerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EventOrganizer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EventOrganizer.t;
}

class EventOrganizerRepository {
  const EventOrganizerRepository._();

  /// Returns a list of [EventOrganizer]s matching the given query parameters.
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
  Future<List<EventOrganizer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventOrganizerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventOrganizerTable>? orderBy,
    _is.OrderByListBuilder<EventOrganizerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EventOrganizer>(
      where: where?.call(EventOrganizer.t),
      orderBy: orderBy?.call(EventOrganizer.t),
      orderByList: orderByList?.call(EventOrganizer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EventOrganizer] matching the given query parameters.
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
  Future<EventOrganizer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventOrganizerTable>? where,
    int? offset,
    _is.OrderByBuilder<EventOrganizerTable>? orderBy,
    _is.OrderByListBuilder<EventOrganizerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EventOrganizer>(
      where: where?.call(EventOrganizer.t),
      orderBy: orderBy?.call(EventOrganizer.t),
      orderByList: orderByList?.call(EventOrganizer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EventOrganizer] by its [id] or null if no such row exists.
  Future<EventOrganizer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EventOrganizer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EventOrganizer]s in the list and returns the inserted rows.
  ///
  /// The returned [EventOrganizer]s will have their `id` fields set.
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
  Future<List<EventOrganizer>> insert(
    _is.DatabaseSession session,
    List<EventOrganizer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EventOrganizer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EventOrganizer] and returns the inserted row.
  ///
  /// The returned [EventOrganizer] will have its `id` field set.
  Future<EventOrganizer> insertRow(
    _is.DatabaseSession session,
    EventOrganizer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EventOrganizer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EventOrganizer]s in the list and returns the resulting rows.
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
  /// The returned [EventOrganizer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventOrganizer>> upsert(
    _is.DatabaseSession session,
    List<EventOrganizer> rows, {
    required _is.ColumnSelections<EventOrganizerTable> conflictColumns,
    _is.ColumnSelections<EventOrganizerTable>? updateColumns,
    _is.WhereExpressionBuilder<EventOrganizerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EventOrganizer>(
      rows,
      conflictColumns: conflictColumns(EventOrganizer.t),
      updateColumns: updateColumns?.call(EventOrganizer.t),
      updateWhere: updateWhere?.call(EventOrganizer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EventOrganizer] and returns the resulting row.
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
  /// The returned [EventOrganizer] will have its `id` field set.
  Future<EventOrganizer?> upsertRow(
    _is.DatabaseSession session,
    EventOrganizer row, {
    required _is.ColumnSelections<EventOrganizerTable> conflictColumns,
    _is.ColumnSelections<EventOrganizerTable>? updateColumns,
    _is.WhereExpressionBuilder<EventOrganizerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EventOrganizer>(
      row,
      conflictColumns: conflictColumns(EventOrganizer.t),
      updateColumns: updateColumns?.call(EventOrganizer.t),
      updateWhere: updateWhere?.call(EventOrganizer.t),
      transaction: transaction,
    );
  }

  /// Updates all [EventOrganizer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventOrganizer>> update(
    _is.DatabaseSession session,
    List<EventOrganizer> rows, {
    _is.ColumnSelections<EventOrganizerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EventOrganizer>(
      rows,
      columns: columns?.call(EventOrganizer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EventOrganizer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EventOrganizer> updateRow(
    _is.DatabaseSession session,
    EventOrganizer row, {
    _is.ColumnSelections<EventOrganizerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EventOrganizer>(
      row,
      columns: columns?.call(EventOrganizer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventOrganizer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EventOrganizer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EventOrganizerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EventOrganizer>(
      id,
      columnValues: columnValues(EventOrganizer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EventOrganizer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventOrganizer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EventOrganizerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EventOrganizerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventOrganizerTable>? orderBy,
    _is.OrderByListBuilder<EventOrganizerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EventOrganizer>(
      columnValues: columnValues(EventOrganizer.t.updateTable),
      where: where(EventOrganizer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventOrganizer.t),
      orderByList: orderByList?.call(EventOrganizer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EventOrganizer]s in the list and returns the deleted rows.
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
  Future<List<EventOrganizer>> delete(
    _is.DatabaseSession session,
    List<EventOrganizer> rows, {
    _is.OrderByBuilder<EventOrganizerTable>? orderBy,
    _is.OrderByListBuilder<EventOrganizerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EventOrganizer>(
      rows,
      orderBy: orderBy?.call(EventOrganizer.t),
      orderByList: orderByList?.call(EventOrganizer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EventOrganizer].
  Future<EventOrganizer> deleteRow(
    _is.DatabaseSession session,
    EventOrganizer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EventOrganizer>(
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
  Future<List<EventOrganizer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventOrganizerTable> where,
    _is.OrderByBuilder<EventOrganizerTable>? orderBy,
    _is.OrderByListBuilder<EventOrganizerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EventOrganizer>(
      where: where(EventOrganizer.t),
      orderBy: orderBy?.call(EventOrganizer.t),
      orderByList: orderByList?.call(EventOrganizer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventOrganizerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EventOrganizer>(
      where: where?.call(EventOrganizer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EventOrganizer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventOrganizerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EventOrganizer>(
      where: where(EventOrganizer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
