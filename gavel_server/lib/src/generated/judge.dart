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

/// A judge seat in an event. Judges authenticate with the secret token in
/// their personal magic link, so they never need an account.
abstract class Judge implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Judge._({
    this.id,
    required this.eventId,
    required this.name,
    this.token,
    double? alpha,
    double? beta,
    bool? active,
    this.currentProjectId,
    this.previousProjectId,
    this.assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    this.simKind,
    this.simNextActionAt,
    DateTime? createdAt,
    this.lastActiveAt,
  }) : alpha = alpha ?? 5.0,
       beta = beta ?? 1.0,
       active = active ?? true,
       votesCast = votesCast ?? 0,
       skips = skips ?? 0,
       isSimulated = isSimulated ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Judge({
    int? id,
    required int eventId,
    required String name,
    String? token,
    double? alpha,
    double? beta,
    bool? active,
    int? currentProjectId,
    int? previousProjectId,
    DateTime? assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    String? simKind,
    DateTime? simNextActionAt,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) = _JudgeImpl;

  factory Judge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Judge(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      name: jsonSerialization['name'] as String,
      token: jsonSerialization['token'] as String?,
      alpha: (jsonSerialization['alpha'] as num?)?.toDouble(),
      beta: (jsonSerialization['beta'] as num?)?.toDouble(),
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      currentProjectId: jsonSerialization['currentProjectId'] as int?,
      previousProjectId: jsonSerialization['previousProjectId'] as int?,
      assignedAt: jsonSerialization['assignedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['assignedAt']),
      votesCast: jsonSerialization['votesCast'] as int?,
      skips: jsonSerialization['skips'] as int?,
      isSimulated: jsonSerialization['isSimulated'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSimulated']),
      simKind: jsonSerialization['simKind'] as String?,
      simNextActionAt: jsonSerialization['simNextActionAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['simNextActionAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastActiveAt: jsonSerialization['lastActiveAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActiveAt'],
            ),
    );
  }

  static final t = JudgeTable();

  static const db = JudgeRepository._();

  @override
  int? id;

  int eventId;

  String name;

  String? token;

  /// Crowd-BT judge reliability prior/posterior: Beta(alpha, beta).
  double alpha;

  double beta;

  bool active;

  /// The project the judge is currently walking to / looking at.
  int? currentProjectId;

  /// The last project the judge judged (the comparison anchor).
  int? previousProjectId;

  DateTime? assignedAt;

  int votesCast;

  int skips;

  bool isSimulated;

  /// careful | noisy | contrarian (demo simulation persona).
  String? simKind;

  DateTime? simNextActionAt;

  DateTime createdAt;

  DateTime? lastActiveAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Judge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Judge copyWith({
    int? id,
    int? eventId,
    String? name,
    String? token,
    double? alpha,
    double? beta,
    bool? active,
    int? currentProjectId,
    int? previousProjectId,
    DateTime? assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    String? simKind,
    DateTime? simNextActionAt,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Judge',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      if (token != null) 'token': token,
      'alpha': alpha,
      'beta': beta,
      'active': active,
      if (currentProjectId != null) 'currentProjectId': currentProjectId,
      if (previousProjectId != null) 'previousProjectId': previousProjectId,
      if (assignedAt != null) 'assignedAt': assignedAt?.toJson(),
      'votesCast': votesCast,
      'skips': skips,
      'isSimulated': isSimulated,
      if (simKind != null) 'simKind': simKind,
      if (simNextActionAt != null) 'simNextActionAt': simNextActionAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (lastActiveAt != null) 'lastActiveAt': lastActiveAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Judge',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'alpha': alpha,
      'beta': beta,
      'active': active,
      if (currentProjectId != null) 'currentProjectId': currentProjectId,
      if (previousProjectId != null) 'previousProjectId': previousProjectId,
      if (assignedAt != null) 'assignedAt': assignedAt?.toJson(),
      'votesCast': votesCast,
      'skips': skips,
      'isSimulated': isSimulated,
      'createdAt': createdAt.toJson(),
      if (lastActiveAt != null) 'lastActiveAt': lastActiveAt?.toJson(),
    };
  }

  static JudgeInclude include() {
    return JudgeInclude._();
  }

  static JudgeIncludeList includeList({
    _is.WhereExpressionBuilder<JudgeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JudgeTable>? orderBy,
    _is.OrderByListBuilder<JudgeTable>? orderByList,
    JudgeInclude? include,
  }) {
    return JudgeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Judge.t),
      orderByList: orderByList?.call(Judge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JudgeImpl extends Judge {
  _JudgeImpl({
    int? id,
    required int eventId,
    required String name,
    String? token,
    double? alpha,
    double? beta,
    bool? active,
    int? currentProjectId,
    int? previousProjectId,
    DateTime? assignedAt,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    String? simKind,
    DateTime? simNextActionAt,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) : super._(
         id: id,
         eventId: eventId,
         name: name,
         token: token,
         alpha: alpha,
         beta: beta,
         active: active,
         currentProjectId: currentProjectId,
         previousProjectId: previousProjectId,
         assignedAt: assignedAt,
         votesCast: votesCast,
         skips: skips,
         isSimulated: isSimulated,
         simKind: simKind,
         simNextActionAt: simNextActionAt,
         createdAt: createdAt,
         lastActiveAt: lastActiveAt,
       );

  /// Returns a shallow copy of this [Judge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Judge copyWith({
    Object? id = _Undefined,
    int? eventId,
    String? name,
    Object? token = _Undefined,
    double? alpha,
    double? beta,
    bool? active,
    Object? currentProjectId = _Undefined,
    Object? previousProjectId = _Undefined,
    Object? assignedAt = _Undefined,
    int? votesCast,
    int? skips,
    bool? isSimulated,
    Object? simKind = _Undefined,
    Object? simNextActionAt = _Undefined,
    DateTime? createdAt,
    Object? lastActiveAt = _Undefined,
  }) {
    return Judge(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      token: token is String? ? token : this.token,
      alpha: alpha ?? this.alpha,
      beta: beta ?? this.beta,
      active: active ?? this.active,
      currentProjectId: currentProjectId is int?
          ? currentProjectId
          : this.currentProjectId,
      previousProjectId: previousProjectId is int?
          ? previousProjectId
          : this.previousProjectId,
      assignedAt: assignedAt is DateTime? ? assignedAt : this.assignedAt,
      votesCast: votesCast ?? this.votesCast,
      skips: skips ?? this.skips,
      isSimulated: isSimulated ?? this.isSimulated,
      simKind: simKind is String? ? simKind : this.simKind,
      simNextActionAt: simNextActionAt is DateTime?
          ? simNextActionAt
          : this.simNextActionAt,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt is DateTime?
          ? lastActiveAt
          : this.lastActiveAt,
    );
  }
}

class JudgeUpdateTable extends _is.UpdateTable<JudgeTable> {
  JudgeUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> token(String? value) => _is.ColumnValue(
    table.token,
    value,
  );

  _is.ColumnValue<double, double> alpha(double value) => _is.ColumnValue(
    table.alpha,
    value,
  );

  _is.ColumnValue<double, double> beta(double value) => _is.ColumnValue(
    table.beta,
    value,
  );

  _is.ColumnValue<bool, bool> active(bool value) => _is.ColumnValue(
    table.active,
    value,
  );

  _is.ColumnValue<int, int> currentProjectId(int? value) => _is.ColumnValue(
    table.currentProjectId,
    value,
  );

  _is.ColumnValue<int, int> previousProjectId(int? value) => _is.ColumnValue(
    table.previousProjectId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> assignedAt(DateTime? value) =>
      _is.ColumnValue(
        table.assignedAt,
        value,
      );

  _is.ColumnValue<int, int> votesCast(int value) => _is.ColumnValue(
    table.votesCast,
    value,
  );

  _is.ColumnValue<int, int> skips(int value) => _is.ColumnValue(
    table.skips,
    value,
  );

  _is.ColumnValue<bool, bool> isSimulated(bool value) => _is.ColumnValue(
    table.isSimulated,
    value,
  );

  _is.ColumnValue<String, String> simKind(String? value) => _is.ColumnValue(
    table.simKind,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> simNextActionAt(DateTime? value) =>
      _is.ColumnValue(
        table.simNextActionAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastActiveAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastActiveAt,
        value,
      );
}

class JudgeTable extends _is.Table<int?> {
  JudgeTable({super.tableRelation}) : super(tableName: 'judge') {
    updateTable = JudgeUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    token = _is.ColumnString(
      'token',
      this,
    );
    alpha = _is.ColumnDouble(
      'alpha',
      this,
      hasDefault: true,
    );
    beta = _is.ColumnDouble(
      'beta',
      this,
      hasDefault: true,
    );
    active = _is.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    currentProjectId = _is.ColumnInt(
      'currentProjectId',
      this,
    );
    previousProjectId = _is.ColumnInt(
      'previousProjectId',
      this,
    );
    assignedAt = _is.ColumnDateTime(
      'assignedAt',
      this,
    );
    votesCast = _is.ColumnInt(
      'votesCast',
      this,
      hasDefault: true,
    );
    skips = _is.ColumnInt(
      'skips',
      this,
      hasDefault: true,
    );
    isSimulated = _is.ColumnBool(
      'isSimulated',
      this,
      hasDefault: true,
    );
    simKind = _is.ColumnString(
      'simKind',
      this,
    );
    simNextActionAt = _is.ColumnDateTime(
      'simNextActionAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    lastActiveAt = _is.ColumnDateTime(
      'lastActiveAt',
      this,
    );
  }

  late final JudgeUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnString name;

  late final _is.ColumnString token;

  /// Crowd-BT judge reliability prior/posterior: Beta(alpha, beta).
  late final _is.ColumnDouble alpha;

  late final _is.ColumnDouble beta;

  late final _is.ColumnBool active;

  /// The project the judge is currently walking to / looking at.
  late final _is.ColumnInt currentProjectId;

  /// The last project the judge judged (the comparison anchor).
  late final _is.ColumnInt previousProjectId;

  late final _is.ColumnDateTime assignedAt;

  late final _is.ColumnInt votesCast;

  late final _is.ColumnInt skips;

  late final _is.ColumnBool isSimulated;

  /// careful | noisy | contrarian (demo simulation persona).
  late final _is.ColumnString simKind;

  late final _is.ColumnDateTime simNextActionAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime lastActiveAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    name,
    token,
    alpha,
    beta,
    active,
    currentProjectId,
    previousProjectId,
    assignedAt,
    votesCast,
    skips,
    isSimulated,
    simKind,
    simNextActionAt,
    createdAt,
    lastActiveAt,
  ];
}

class JudgeInclude extends _is.IncludeObject {
  JudgeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Judge.t;
}

class JudgeIncludeList extends _is.IncludeList {
  JudgeIncludeList._({
    _is.WhereExpressionBuilder<JudgeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Judge.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Judge.t;
}

class JudgeRepository {
  const JudgeRepository._();

  /// Returns a list of [Judge]s matching the given query parameters.
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
  Future<List<Judge>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JudgeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JudgeTable>? orderBy,
    _is.OrderByListBuilder<JudgeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Judge>(
      where: where?.call(Judge.t),
      orderBy: orderBy?.call(Judge.t),
      orderByList: orderByList?.call(Judge.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Judge] matching the given query parameters.
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
  Future<Judge?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JudgeTable>? where,
    int? offset,
    _is.OrderByBuilder<JudgeTable>? orderBy,
    _is.OrderByListBuilder<JudgeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Judge>(
      where: where?.call(Judge.t),
      orderBy: orderBy?.call(Judge.t),
      orderByList: orderByList?.call(Judge.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Judge] by its [id] or null if no such row exists.
  Future<Judge?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Judge>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Judge]s in the list and returns the inserted rows.
  ///
  /// The returned [Judge]s will have their `id` fields set.
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
  Future<List<Judge>> insert(
    _is.DatabaseSession session,
    List<Judge> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Judge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Judge] and returns the inserted row.
  ///
  /// The returned [Judge] will have its `id` field set.
  Future<Judge> insertRow(
    _is.DatabaseSession session,
    Judge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Judge>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Judge]s in the list and returns the resulting rows.
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
  /// The returned [Judge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Judge>> upsert(
    _is.DatabaseSession session,
    List<Judge> rows, {
    required _is.ColumnSelections<JudgeTable> conflictColumns,
    _is.ColumnSelections<JudgeTable>? updateColumns,
    _is.WhereExpressionBuilder<JudgeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Judge>(
      rows,
      conflictColumns: conflictColumns(Judge.t),
      updateColumns: updateColumns?.call(Judge.t),
      updateWhere: updateWhere?.call(Judge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Judge] and returns the resulting row.
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
  /// The returned [Judge] will have its `id` field set.
  Future<Judge?> upsertRow(
    _is.DatabaseSession session,
    Judge row, {
    required _is.ColumnSelections<JudgeTable> conflictColumns,
    _is.ColumnSelections<JudgeTable>? updateColumns,
    _is.WhereExpressionBuilder<JudgeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Judge>(
      row,
      conflictColumns: conflictColumns(Judge.t),
      updateColumns: updateColumns?.call(Judge.t),
      updateWhere: updateWhere?.call(Judge.t),
      transaction: transaction,
    );
  }

  /// Updates all [Judge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Judge>> update(
    _is.DatabaseSession session,
    List<Judge> rows, {
    _is.ColumnSelections<JudgeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Judge>(
      rows,
      columns: columns?.call(Judge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Judge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Judge> updateRow(
    _is.DatabaseSession session,
    Judge row, {
    _is.ColumnSelections<JudgeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Judge>(
      row,
      columns: columns?.call(Judge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Judge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Judge?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JudgeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Judge>(
      id,
      columnValues: columnValues(Judge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Judge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Judge>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JudgeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JudgeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JudgeTable>? orderBy,
    _is.OrderByListBuilder<JudgeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Judge>(
      columnValues: columnValues(Judge.t.updateTable),
      where: where(Judge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Judge.t),
      orderByList: orderByList?.call(Judge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Judge]s in the list and returns the deleted rows.
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
  Future<List<Judge>> delete(
    _is.DatabaseSession session,
    List<Judge> rows, {
    _is.OrderByBuilder<JudgeTable>? orderBy,
    _is.OrderByListBuilder<JudgeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Judge>(
      rows,
      orderBy: orderBy?.call(Judge.t),
      orderByList: orderByList?.call(Judge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Judge].
  Future<Judge> deleteRow(
    _is.DatabaseSession session,
    Judge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Judge>(
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
  Future<List<Judge>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JudgeTable> where,
    _is.OrderByBuilder<JudgeTable>? orderBy,
    _is.OrderByListBuilder<JudgeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Judge>(
      where: where(Judge.t),
      orderBy: orderBy?.call(Judge.t),
      orderByList: orderByList?.call(Judge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JudgeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Judge>(
      where: where?.call(Judge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Judge] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JudgeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Judge>(
      where: where(Judge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
