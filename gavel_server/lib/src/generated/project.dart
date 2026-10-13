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

/// A project (team / table) competing in an event.
abstract class Project
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Project._({
    this.id,
    required this.eventId,
    required this.name,
    required this.location,
    required this.description,
    this.team,
    this.link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    this.simTrueScore,
    DateTime? createdAt,
  }) : mu = mu ?? 0.0,
       sigmaSq = sigmaSq ?? 1.0,
       active = active ?? true,
       prioritized = prioritized ?? false,
       timesSeen = timesSeen ?? 0,
       absentReports = absentReports ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Project({
    int? id,
    required int eventId,
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    double? simTrueScore,
    DateTime? createdAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String,
      description: jsonSerialization['description'] as String,
      team: jsonSerialization['team'] as String?,
      link: jsonSerialization['link'] as String?,
      mu: (jsonSerialization['mu'] as num?)?.toDouble(),
      sigmaSq: (jsonSerialization['sigmaSq'] as num?)?.toDouble(),
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      prioritized: jsonSerialization['prioritized'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['prioritized']),
      timesSeen: jsonSerialization['timesSeen'] as int?,
      absentReports: jsonSerialization['absentReports'] as int?,
      simTrueScore: (jsonSerialization['simTrueScore'] as num?)?.toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ProjectTable();

  static const db = ProjectRepository._();

  @override
  int? id;

  int eventId;

  String name;

  /// Where judges find it, e.g. "Table 12".
  String location;

  String description;

  String? team;

  String? link;

  /// Crowd-BT posterior: mean quality estimate.
  double mu;

  /// Crowd-BT posterior: variance of the quality estimate.
  double sigmaSq;

  /// Inactive projects are never assigned (absent, withdrawn...).
  bool active;

  /// Prioritized projects are visited before everything else.
  bool prioritized;

  int timesSeen;

  int absentReports;

  /// Hidden ground-truth quality used only by demo simulations.
  double? simTrueScore;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Project copyWith({
    int? id,
    int? eventId,
    String? name,
    String? location,
    String? description,
    String? team,
    String? link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    double? simTrueScore,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'active': active,
      'prioritized': prioritized,
      'timesSeen': timesSeen,
      'absentReports': absentReports,
      if (simTrueScore != null) 'simTrueScore': simTrueScore,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'eventId': eventId,
      'name': name,
      'location': location,
      'description': description,
      if (team != null) 'team': team,
      if (link != null) 'link': link,
      'mu': mu,
      'sigmaSq': sigmaSq,
      'active': active,
      'prioritized': prioritized,
      'timesSeen': timesSeen,
      'absentReports': absentReports,
      'createdAt': createdAt.toJson(),
    };
  }

  static ProjectInclude include() {
    return ProjectInclude._();
  }

  static ProjectIncludeList includeList({
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    ProjectInclude? include,
  }) {
    return ProjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int eventId,
    required String name,
    required String location,
    required String description,
    String? team,
    String? link,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    double? simTrueScore,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         name: name,
         location: location,
         description: description,
         team: team,
         link: link,
         mu: mu,
         sigmaSq: sigmaSq,
         active: active,
         prioritized: prioritized,
         timesSeen: timesSeen,
         absentReports: absentReports,
         simTrueScore: simTrueScore,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? eventId,
    String? name,
    String? location,
    String? description,
    Object? team = _Undefined,
    Object? link = _Undefined,
    double? mu,
    double? sigmaSq,
    bool? active,
    bool? prioritized,
    int? timesSeen,
    int? absentReports,
    Object? simTrueScore = _Undefined,
    DateTime? createdAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      team: team is String? ? team : this.team,
      link: link is String? ? link : this.link,
      mu: mu ?? this.mu,
      sigmaSq: sigmaSq ?? this.sigmaSq,
      active: active ?? this.active,
      prioritized: prioritized ?? this.prioritized,
      timesSeen: timesSeen ?? this.timesSeen,
      absentReports: absentReports ?? this.absentReports,
      simTrueScore: simTrueScore is double? ? simTrueScore : this.simTrueScore,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProjectUpdateTable extends _is.UpdateTable<ProjectTable> {
  ProjectUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> location(String value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> team(String? value) => _is.ColumnValue(
    table.team,
    value,
  );

  _is.ColumnValue<String, String> link(String? value) => _is.ColumnValue(
    table.link,
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

  _is.ColumnValue<bool, bool> active(bool value) => _is.ColumnValue(
    table.active,
    value,
  );

  _is.ColumnValue<bool, bool> prioritized(bool value) => _is.ColumnValue(
    table.prioritized,
    value,
  );

  _is.ColumnValue<int, int> timesSeen(int value) => _is.ColumnValue(
    table.timesSeen,
    value,
  );

  _is.ColumnValue<int, int> absentReports(int value) => _is.ColumnValue(
    table.absentReports,
    value,
  );

  _is.ColumnValue<double, double> simTrueScore(double? value) =>
      _is.ColumnValue(
        table.simTrueScore,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ProjectTable extends _is.Table<int?> {
  ProjectTable({super.tableRelation}) : super(tableName: 'project') {
    updateTable = ProjectUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    team = _is.ColumnString(
      'team',
      this,
    );
    link = _is.ColumnString(
      'link',
      this,
    );
    mu = _is.ColumnDouble(
      'mu',
      this,
      hasDefault: true,
    );
    sigmaSq = _is.ColumnDouble(
      'sigmaSq',
      this,
      hasDefault: true,
    );
    active = _is.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    prioritized = _is.ColumnBool(
      'prioritized',
      this,
      hasDefault: true,
    );
    timesSeen = _is.ColumnInt(
      'timesSeen',
      this,
      hasDefault: true,
    );
    absentReports = _is.ColumnInt(
      'absentReports',
      this,
      hasDefault: true,
    );
    simTrueScore = _is.ColumnDouble(
      'simTrueScore',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ProjectUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnString name;

  /// Where judges find it, e.g. "Table 12".
  late final _is.ColumnString location;

  late final _is.ColumnString description;

  late final _is.ColumnString team;

  late final _is.ColumnString link;

  /// Crowd-BT posterior: mean quality estimate.
  late final _is.ColumnDouble mu;

  /// Crowd-BT posterior: variance of the quality estimate.
  late final _is.ColumnDouble sigmaSq;

  /// Inactive projects are never assigned (absent, withdrawn...).
  late final _is.ColumnBool active;

  /// Prioritized projects are visited before everything else.
  late final _is.ColumnBool prioritized;

  late final _is.ColumnInt timesSeen;

  late final _is.ColumnInt absentReports;

  /// Hidden ground-truth quality used only by demo simulations.
  late final _is.ColumnDouble simTrueScore;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    name,
    location,
    description,
    team,
    link,
    mu,
    sigmaSq,
    active,
    prioritized,
    timesSeen,
    absentReports,
    simTrueScore,
    createdAt,
  ];
}

class ProjectInclude extends _is.IncludeObject {
  ProjectInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Project.t;
}

class ProjectIncludeList extends _is.IncludeList {
  ProjectIncludeList._({
    _is.WhereExpressionBuilder<ProjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Project.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Project.t;
}

class ProjectRepository {
  const ProjectRepository._();

  /// Returns a list of [Project]s matching the given query parameters.
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
  Future<List<Project>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Project>(
      where: where?.call(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Project] matching the given query parameters.
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
  Future<Project?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Project>(
      where: where?.call(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Project] by its [id] or null if no such row exists.
  Future<Project?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Project>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Project]s in the list and returns the inserted rows.
  ///
  /// The returned [Project]s will have their `id` fields set.
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
  Future<List<Project>> insert(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Project>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Project] and returns the inserted row.
  ///
  /// The returned [Project] will have its `id` field set.
  Future<Project> insertRow(
    _is.DatabaseSession session,
    Project row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Project>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Project]s in the list and returns the resulting rows.
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
  /// The returned [Project]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> upsert(
    _is.DatabaseSession session,
    List<Project> rows, {
    required _is.ColumnSelections<ProjectTable> conflictColumns,
    _is.ColumnSelections<ProjectTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Project>(
      rows,
      conflictColumns: conflictColumns(Project.t),
      updateColumns: updateColumns?.call(Project.t),
      updateWhere: updateWhere?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Project] and returns the resulting row.
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
  /// The returned [Project] will have its `id` field set.
  Future<Project?> upsertRow(
    _is.DatabaseSession session,
    Project row, {
    required _is.ColumnSelections<ProjectTable> conflictColumns,
    _is.ColumnSelections<ProjectTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Project>(
      row,
      conflictColumns: conflictColumns(Project.t),
      updateColumns: updateColumns?.call(Project.t),
      updateWhere: updateWhere?.call(Project.t),
      transaction: transaction,
    );
  }

  /// Updates all [Project]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> update(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.ColumnSelections<ProjectTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Project>(
      rows,
      columns: columns?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Project]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Project> updateRow(
    _is.DatabaseSession session,
    Project row, {
    _is.ColumnSelections<ProjectTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Project>(
      row,
      columns: columns?.call(Project.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Project] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Project?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProjectUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Project>(
      id,
      columnValues: columnValues(Project.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Project]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProjectUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProjectTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Project>(
      columnValues: columnValues(Project.t.updateTable),
      where: where(Project.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Project]s in the list and returns the deleted rows.
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
  Future<List<Project>> delete(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Project>(
      rows,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Project].
  Future<Project> deleteRow(
    _is.DatabaseSession session,
    Project row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Project>(
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
  Future<List<Project>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectTable> where,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Project>(
      where: where(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Project>(
      where: where?.call(Project.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Project] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Project>(
      where: where(Project.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
