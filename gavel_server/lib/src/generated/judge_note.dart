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
import 'note_source.dart' as _imwmkxfc;

/// A note a judge left about a project, typed or dictated (ElevenLabs STT).
abstract class JudgeNote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  JudgeNote._({
    this.id,
    required this.eventId,
    required this.judgeId,
    required this.projectId,
    required this.text,
    required this.source,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory JudgeNote({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required String text,
    required _imwmkxfc.NoteSource source,
    DateTime? createdAt,
  }) = _JudgeNoteImpl;

  factory JudgeNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return JudgeNote(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      judgeId: jsonSerialization['judgeId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      text: jsonSerialization['text'] as String,
      source: _imwmkxfc.NoteSource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = JudgeNoteTable();

  static const db = JudgeNoteRepository._();

  @override
  int? id;

  int eventId;

  int judgeId;

  int projectId;

  String text;

  _imwmkxfc.NoteSource source;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [JudgeNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JudgeNote copyWith({
    int? id,
    int? eventId,
    int? judgeId,
    int? projectId,
    String? text,
    _imwmkxfc.NoteSource? source,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JudgeNote',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'text': text,
      'source': source.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JudgeNote',
      if (id != null) 'id': id,
      'eventId': eventId,
      'judgeId': judgeId,
      'projectId': projectId,
      'text': text,
      'source': source.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static JudgeNoteInclude include() {
    return JudgeNoteInclude._();
  }

  static JudgeNoteIncludeList includeList({
    _is.WhereExpressionBuilder<JudgeNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JudgeNoteTable>? orderBy,
    _is.OrderByListBuilder<JudgeNoteTable>? orderByList,
    JudgeNoteInclude? include,
  }) {
    return JudgeNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JudgeNote.t),
      orderByList: orderByList?.call(JudgeNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JudgeNoteImpl extends JudgeNote {
  _JudgeNoteImpl({
    int? id,
    required int eventId,
    required int judgeId,
    required int projectId,
    required String text,
    required _imwmkxfc.NoteSource source,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         judgeId: judgeId,
         projectId: projectId,
         text: text,
         source: source,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [JudgeNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JudgeNote copyWith({
    Object? id = _Undefined,
    int? eventId,
    int? judgeId,
    int? projectId,
    String? text,
    _imwmkxfc.NoteSource? source,
    DateTime? createdAt,
  }) {
    return JudgeNote(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      judgeId: judgeId ?? this.judgeId,
      projectId: projectId ?? this.projectId,
      text: text ?? this.text,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class JudgeNoteUpdateTable extends _is.UpdateTable<JudgeNoteTable> {
  JudgeNoteUpdateTable(super.table);

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

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<_imwmkxfc.NoteSource, _imwmkxfc.NoteSource> source(
    _imwmkxfc.NoteSource value,
  ) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class JudgeNoteTable extends _is.Table<int?> {
  JudgeNoteTable({super.tableRelation}) : super(tableName: 'judge_note') {
    updateTable = JudgeNoteUpdateTable(this);
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
    text = _is.ColumnString(
      'text',
      this,
    );
    source = _is.ColumnEnum(
      'source',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final JudgeNoteUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnInt judgeId;

  late final _is.ColumnInt projectId;

  late final _is.ColumnString text;

  late final _is.ColumnEnum<_imwmkxfc.NoteSource> source;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    judgeId,
    projectId,
    text,
    source,
    createdAt,
  ];
}

class JudgeNoteInclude extends _is.IncludeObject {
  JudgeNoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => JudgeNote.t;
}

class JudgeNoteIncludeList extends _is.IncludeList {
  JudgeNoteIncludeList._({
    _is.WhereExpressionBuilder<JudgeNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JudgeNote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => JudgeNote.t;
}

class JudgeNoteRepository {
  const JudgeNoteRepository._();

  /// Returns a list of [JudgeNote]s matching the given query parameters.
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
  Future<List<JudgeNote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JudgeNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JudgeNoteTable>? orderBy,
    _is.OrderByListBuilder<JudgeNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JudgeNote>(
      where: where?.call(JudgeNote.t),
      orderBy: orderBy?.call(JudgeNote.t),
      orderByList: orderByList?.call(JudgeNote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JudgeNote] matching the given query parameters.
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
  Future<JudgeNote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JudgeNoteTable>? where,
    int? offset,
    _is.OrderByBuilder<JudgeNoteTable>? orderBy,
    _is.OrderByListBuilder<JudgeNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JudgeNote>(
      where: where?.call(JudgeNote.t),
      orderBy: orderBy?.call(JudgeNote.t),
      orderByList: orderByList?.call(JudgeNote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JudgeNote] by its [id] or null if no such row exists.
  Future<JudgeNote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JudgeNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JudgeNote]s in the list and returns the inserted rows.
  ///
  /// The returned [JudgeNote]s will have their `id` fields set.
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
  Future<List<JudgeNote>> insert(
    _is.DatabaseSession session,
    List<JudgeNote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<JudgeNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [JudgeNote] and returns the inserted row.
  ///
  /// The returned [JudgeNote] will have its `id` field set.
  Future<JudgeNote> insertRow(
    _is.DatabaseSession session,
    JudgeNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<JudgeNote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [JudgeNote]s in the list and returns the resulting rows.
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
  /// The returned [JudgeNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JudgeNote>> upsert(
    _is.DatabaseSession session,
    List<JudgeNote> rows, {
    required _is.ColumnSelections<JudgeNoteTable> conflictColumns,
    _is.ColumnSelections<JudgeNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<JudgeNoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<JudgeNote>(
      rows,
      conflictColumns: conflictColumns(JudgeNote.t),
      updateColumns: updateColumns?.call(JudgeNote.t),
      updateWhere: updateWhere?.call(JudgeNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [JudgeNote] and returns the resulting row.
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
  /// The returned [JudgeNote] will have its `id` field set.
  Future<JudgeNote?> upsertRow(
    _is.DatabaseSession session,
    JudgeNote row, {
    required _is.ColumnSelections<JudgeNoteTable> conflictColumns,
    _is.ColumnSelections<JudgeNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<JudgeNoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<JudgeNote>(
      row,
      conflictColumns: conflictColumns(JudgeNote.t),
      updateColumns: updateColumns?.call(JudgeNote.t),
      updateWhere: updateWhere?.call(JudgeNote.t),
      transaction: transaction,
    );
  }

  /// Updates all [JudgeNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JudgeNote>> update(
    _is.DatabaseSession session,
    List<JudgeNote> rows, {
    _is.ColumnSelections<JudgeNoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<JudgeNote>(
      rows,
      columns: columns?.call(JudgeNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [JudgeNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JudgeNote> updateRow(
    _is.DatabaseSession session,
    JudgeNote row, {
    _is.ColumnSelections<JudgeNoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<JudgeNote>(
      row,
      columns: columns?.call(JudgeNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JudgeNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JudgeNote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JudgeNoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<JudgeNote>(
      id,
      columnValues: columnValues(JudgeNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JudgeNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JudgeNote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JudgeNoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JudgeNoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JudgeNoteTable>? orderBy,
    _is.OrderByListBuilder<JudgeNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<JudgeNote>(
      columnValues: columnValues(JudgeNote.t.updateTable),
      where: where(JudgeNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JudgeNote.t),
      orderByList: orderByList?.call(JudgeNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [JudgeNote]s in the list and returns the deleted rows.
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
  Future<List<JudgeNote>> delete(
    _is.DatabaseSession session,
    List<JudgeNote> rows, {
    _is.OrderByBuilder<JudgeNoteTable>? orderBy,
    _is.OrderByListBuilder<JudgeNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<JudgeNote>(
      rows,
      orderBy: orderBy?.call(JudgeNote.t),
      orderByList: orderByList?.call(JudgeNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [JudgeNote].
  Future<JudgeNote> deleteRow(
    _is.DatabaseSession session,
    JudgeNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JudgeNote>(
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
  Future<List<JudgeNote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JudgeNoteTable> where,
    _is.OrderByBuilder<JudgeNoteTable>? orderBy,
    _is.OrderByListBuilder<JudgeNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<JudgeNote>(
      where: where(JudgeNote.t),
      orderBy: orderBy?.call(JudgeNote.t),
      orderByList: orderByList?.call(JudgeNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JudgeNoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<JudgeNote>(
      where: where?.call(JudgeNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JudgeNote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JudgeNoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JudgeNote>(
      where: where(JudgeNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
