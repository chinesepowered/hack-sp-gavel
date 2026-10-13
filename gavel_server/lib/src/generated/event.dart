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
import 'event_status.dart' as _ip80g9gw;

/// A judging event (a hackathon expo, a science fair, a pitch night...).
abstract class Event implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Event._({
    this.id,
    required this.name,
    this.tagline,
    required this.slug,
    required this.judgeCode,
    this.adminKey,
    this.ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    this.closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    this.announcementUrl,
    this.announcementScript,
    DateTime? createdAt,
  }) : status = status ?? _ip80g9gw.EventStatus.setup,
       minViews = minViews ?? 2,
       assignmentTimeoutMinutes = assignmentTimeoutMinutes ?? 5,
       resultsPublished = resultsPublished ?? false,
       isDemo = isDemo ?? false,
       simulationRunning = simulationRunning ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Event({
    int? id,
    required String name,
    String? tagline,
    required String slug,
    required String judgeCode,
    String? adminKey,
    _is.UuidValue? ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    DateTime? closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    String? announcementUrl,
    String? announcementScript,
    DateTime? createdAt,
  }) = _EventImpl;

  factory Event.fromJson(Map<String, dynamic> jsonSerialization) {
    return Event(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      tagline: jsonSerialization['tagline'] as String?,
      slug: jsonSerialization['slug'] as String,
      judgeCode: jsonSerialization['judgeCode'] as String,
      adminKey: jsonSerialization['adminKey'] as String?,
      ownerId: jsonSerialization['ownerId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['ownerId']),
      status: jsonSerialization['status'] == null
          ? null
          : _ip80g9gw.EventStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      minViews: jsonSerialization['minViews'] as int?,
      assignmentTimeoutMinutes:
          jsonSerialization['assignmentTimeoutMinutes'] as int?,
      closesAt: jsonSerialization['closesAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['closesAt']),
      resultsPublished: jsonSerialization['resultsPublished'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['resultsPublished'],
            ),
      isDemo: jsonSerialization['isDemo'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      simulationRunning: jsonSerialization['simulationRunning'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['simulationRunning'],
            ),
      announcementUrl: jsonSerialization['announcementUrl'] as String?,
      announcementScript: jsonSerialization['announcementScript'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EventTable();

  static const db = EventRepository._();

  @override
  int? id;

  String name;

  String? tagline;

  /// Public, URL-safe identifier used for share links and the results page.
  String slug;

  /// Short code judges type (or scan) to join.
  String judgeCode;

  /// Secret that grants organizer access to whoever holds the admin link.
  String? adminKey;

  /// The auth user that created the event.
  _is.UuidValue? ownerId;

  _ip80g9gw.EventStatus status;

  /// Every project should be seen at least this many times before the
  /// ranking engine optimizes purely for information gain.
  int minViews;

  /// A project a judge was sent to counts as busy for this long.
  int assignmentTimeoutMinutes;

  /// When set, judging closes automatically at this time (future call).
  DateTime? closesAt;

  /// When the public results page is visible.
  bool resultsPublished;

  /// Sandbox events created from "Try the demo"; expire after 24h.
  bool isDemo;

  bool simulationRunning;

  /// Public URL of the ElevenLabs awards announcement, once generated.
  String? announcementUrl;

  String? announcementScript;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Event copyWith({
    int? id,
    String? name,
    String? tagline,
    String? slug,
    String? judgeCode,
    String? adminKey,
    _is.UuidValue? ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    DateTime? closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    String? announcementUrl,
    String? announcementScript,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id,
      'name': name,
      if (tagline != null) 'tagline': tagline,
      'slug': slug,
      'judgeCode': judgeCode,
      if (adminKey != null) 'adminKey': adminKey,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      'status': status.toJson(),
      'minViews': minViews,
      'assignmentTimeoutMinutes': assignmentTimeoutMinutes,
      if (closesAt != null) 'closesAt': closesAt?.toJson(),
      'resultsPublished': resultsPublished,
      'isDemo': isDemo,
      'simulationRunning': simulationRunning,
      if (announcementUrl != null) 'announcementUrl': announcementUrl,
      if (announcementScript != null) 'announcementScript': announcementScript,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id,
      'name': name,
      if (tagline != null) 'tagline': tagline,
      'slug': slug,
      'judgeCode': judgeCode,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      'status': status.toJson(),
      'minViews': minViews,
      'assignmentTimeoutMinutes': assignmentTimeoutMinutes,
      if (closesAt != null) 'closesAt': closesAt?.toJson(),
      'resultsPublished': resultsPublished,
      'isDemo': isDemo,
      'simulationRunning': simulationRunning,
      if (announcementUrl != null) 'announcementUrl': announcementUrl,
      if (announcementScript != null) 'announcementScript': announcementScript,
      'createdAt': createdAt.toJson(),
    };
  }

  static EventInclude include() {
    return EventInclude._();
  }

  static EventIncludeList includeList({
    _is.WhereExpressionBuilder<EventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventTable>? orderBy,
    _is.OrderByListBuilder<EventTable>? orderByList,
    EventInclude? include,
  }) {
    return EventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventImpl extends Event {
  _EventImpl({
    int? id,
    required String name,
    String? tagline,
    required String slug,
    required String judgeCode,
    String? adminKey,
    _is.UuidValue? ownerId,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    DateTime? closesAt,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    String? announcementUrl,
    String? announcementScript,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         tagline: tagline,
         slug: slug,
         judgeCode: judgeCode,
         adminKey: adminKey,
         ownerId: ownerId,
         status: status,
         minViews: minViews,
         assignmentTimeoutMinutes: assignmentTimeoutMinutes,
         closesAt: closesAt,
         resultsPublished: resultsPublished,
         isDemo: isDemo,
         simulationRunning: simulationRunning,
         announcementUrl: announcementUrl,
         announcementScript: announcementScript,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Event copyWith({
    Object? id = _Undefined,
    String? name,
    Object? tagline = _Undefined,
    String? slug,
    String? judgeCode,
    Object? adminKey = _Undefined,
    Object? ownerId = _Undefined,
    _ip80g9gw.EventStatus? status,
    int? minViews,
    int? assignmentTimeoutMinutes,
    Object? closesAt = _Undefined,
    bool? resultsPublished,
    bool? isDemo,
    bool? simulationRunning,
    Object? announcementUrl = _Undefined,
    Object? announcementScript = _Undefined,
    DateTime? createdAt,
  }) {
    return Event(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      tagline: tagline is String? ? tagline : this.tagline,
      slug: slug ?? this.slug,
      judgeCode: judgeCode ?? this.judgeCode,
      adminKey: adminKey is String? ? adminKey : this.adminKey,
      ownerId: ownerId is _is.UuidValue? ? ownerId : this.ownerId,
      status: status ?? this.status,
      minViews: minViews ?? this.minViews,
      assignmentTimeoutMinutes:
          assignmentTimeoutMinutes ?? this.assignmentTimeoutMinutes,
      closesAt: closesAt is DateTime? ? closesAt : this.closesAt,
      resultsPublished: resultsPublished ?? this.resultsPublished,
      isDemo: isDemo ?? this.isDemo,
      simulationRunning: simulationRunning ?? this.simulationRunning,
      announcementUrl: announcementUrl is String?
          ? announcementUrl
          : this.announcementUrl,
      announcementScript: announcementScript is String?
          ? announcementScript
          : this.announcementScript,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EventUpdateTable extends _is.UpdateTable<EventTable> {
  EventUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> tagline(String? value) => _is.ColumnValue(
    table.tagline,
    value,
  );

  _is.ColumnValue<String, String> slug(String value) => _is.ColumnValue(
    table.slug,
    value,
  );

  _is.ColumnValue<String, String> judgeCode(String value) => _is.ColumnValue(
    table.judgeCode,
    value,
  );

  _is.ColumnValue<String, String> adminKey(String? value) => _is.ColumnValue(
    table.adminKey,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue? value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<_ip80g9gw.EventStatus, _ip80g9gw.EventStatus> status(
    _ip80g9gw.EventStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> minViews(int value) => _is.ColumnValue(
    table.minViews,
    value,
  );

  _is.ColumnValue<int, int> assignmentTimeoutMinutes(int value) =>
      _is.ColumnValue(
        table.assignmentTimeoutMinutes,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> closesAt(DateTime? value) =>
      _is.ColumnValue(
        table.closesAt,
        value,
      );

  _is.ColumnValue<bool, bool> resultsPublished(bool value) => _is.ColumnValue(
    table.resultsPublished,
    value,
  );

  _is.ColumnValue<bool, bool> isDemo(bool value) => _is.ColumnValue(
    table.isDemo,
    value,
  );

  _is.ColumnValue<bool, bool> simulationRunning(bool value) => _is.ColumnValue(
    table.simulationRunning,
    value,
  );

  _is.ColumnValue<String, String> announcementUrl(String? value) =>
      _is.ColumnValue(
        table.announcementUrl,
        value,
      );

  _is.ColumnValue<String, String> announcementScript(String? value) =>
      _is.ColumnValue(
        table.announcementScript,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class EventTable extends _is.Table<int?> {
  EventTable({super.tableRelation}) : super(tableName: 'event') {
    updateTable = EventUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    tagline = _is.ColumnString(
      'tagline',
      this,
    );
    slug = _is.ColumnString(
      'slug',
      this,
    );
    judgeCode = _is.ColumnString(
      'judgeCode',
      this,
    );
    adminKey = _is.ColumnString(
      'adminKey',
      this,
    );
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    minViews = _is.ColumnInt(
      'minViews',
      this,
      hasDefault: true,
    );
    assignmentTimeoutMinutes = _is.ColumnInt(
      'assignmentTimeoutMinutes',
      this,
      hasDefault: true,
    );
    closesAt = _is.ColumnDateTime(
      'closesAt',
      this,
    );
    resultsPublished = _is.ColumnBool(
      'resultsPublished',
      this,
      hasDefault: true,
    );
    isDemo = _is.ColumnBool(
      'isDemo',
      this,
      hasDefault: true,
    );
    simulationRunning = _is.ColumnBool(
      'simulationRunning',
      this,
      hasDefault: true,
    );
    announcementUrl = _is.ColumnString(
      'announcementUrl',
      this,
    );
    announcementScript = _is.ColumnString(
      'announcementScript',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final EventUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString tagline;

  /// Public, URL-safe identifier used for share links and the results page.
  late final _is.ColumnString slug;

  /// Short code judges type (or scan) to join.
  late final _is.ColumnString judgeCode;

  /// Secret that grants organizer access to whoever holds the admin link.
  late final _is.ColumnString adminKey;

  /// The auth user that created the event.
  late final _is.ColumnUuid ownerId;

  late final _is.ColumnEnum<_ip80g9gw.EventStatus> status;

  /// Every project should be seen at least this many times before the
  /// ranking engine optimizes purely for information gain.
  late final _is.ColumnInt minViews;

  /// A project a judge was sent to counts as busy for this long.
  late final _is.ColumnInt assignmentTimeoutMinutes;

  /// When set, judging closes automatically at this time (future call).
  late final _is.ColumnDateTime closesAt;

  /// When the public results page is visible.
  late final _is.ColumnBool resultsPublished;

  /// Sandbox events created from "Try the demo"; expire after 24h.
  late final _is.ColumnBool isDemo;

  late final _is.ColumnBool simulationRunning;

  /// Public URL of the ElevenLabs awards announcement, once generated.
  late final _is.ColumnString announcementUrl;

  late final _is.ColumnString announcementScript;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    tagline,
    slug,
    judgeCode,
    adminKey,
    ownerId,
    status,
    minViews,
    assignmentTimeoutMinutes,
    closesAt,
    resultsPublished,
    isDemo,
    simulationRunning,
    announcementUrl,
    announcementScript,
    createdAt,
  ];
}

class EventInclude extends _is.IncludeObject {
  EventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Event.t;
}

class EventIncludeList extends _is.IncludeList {
  EventIncludeList._({
    _is.WhereExpressionBuilder<EventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Event.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Event.t;
}

class EventRepository {
  const EventRepository._();

  /// Returns a list of [Event]s matching the given query parameters.
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
  Future<List<Event>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventTable>? orderBy,
    _is.OrderByListBuilder<EventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Event>(
      where: where?.call(Event.t),
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Event] matching the given query parameters.
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
  Future<Event?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventTable>? where,
    int? offset,
    _is.OrderByBuilder<EventTable>? orderBy,
    _is.OrderByListBuilder<EventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Event>(
      where: where?.call(Event.t),
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Event] by its [id] or null if no such row exists.
  Future<Event?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Event>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Event]s in the list and returns the inserted rows.
  ///
  /// The returned [Event]s will have their `id` fields set.
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
  Future<List<Event>> insert(
    _is.DatabaseSession session,
    List<Event> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Event>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Event] and returns the inserted row.
  ///
  /// The returned [Event] will have its `id` field set.
  Future<Event> insertRow(
    _is.DatabaseSession session,
    Event row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Event>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Event]s in the list and returns the resulting rows.
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
  /// The returned [Event]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Event>> upsert(
    _is.DatabaseSession session,
    List<Event> rows, {
    required _is.ColumnSelections<EventTable> conflictColumns,
    _is.ColumnSelections<EventTable>? updateColumns,
    _is.WhereExpressionBuilder<EventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Event>(
      rows,
      conflictColumns: conflictColumns(Event.t),
      updateColumns: updateColumns?.call(Event.t),
      updateWhere: updateWhere?.call(Event.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Event] and returns the resulting row.
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
  /// The returned [Event] will have its `id` field set.
  Future<Event?> upsertRow(
    _is.DatabaseSession session,
    Event row, {
    required _is.ColumnSelections<EventTable> conflictColumns,
    _is.ColumnSelections<EventTable>? updateColumns,
    _is.WhereExpressionBuilder<EventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Event>(
      row,
      conflictColumns: conflictColumns(Event.t),
      updateColumns: updateColumns?.call(Event.t),
      updateWhere: updateWhere?.call(Event.t),
      transaction: transaction,
    );
  }

  /// Updates all [Event]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Event>> update(
    _is.DatabaseSession session,
    List<Event> rows, {
    _is.ColumnSelections<EventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Event>(
      rows,
      columns: columns?.call(Event.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Event]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Event> updateRow(
    _is.DatabaseSession session,
    Event row, {
    _is.ColumnSelections<EventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Event>(
      row,
      columns: columns?.call(Event.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Event] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Event?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Event>(
      id,
      columnValues: columnValues(Event.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Event]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Event>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventTable>? orderBy,
    _is.OrderByListBuilder<EventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Event>(
      columnValues: columnValues(Event.t.updateTable),
      where: where(Event.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Event]s in the list and returns the deleted rows.
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
  Future<List<Event>> delete(
    _is.DatabaseSession session,
    List<Event> rows, {
    _is.OrderByBuilder<EventTable>? orderBy,
    _is.OrderByListBuilder<EventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Event>(
      rows,
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Event].
  Future<Event> deleteRow(
    _is.DatabaseSession session,
    Event row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Event>(
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
  Future<List<Event>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventTable> where,
    _is.OrderByBuilder<EventTable>? orderBy,
    _is.OrderByListBuilder<EventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Event>(
      where: where(Event.t),
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Event>(
      where: where?.call(Event.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Event] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Event>(
      where: where(Event.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
