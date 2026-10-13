/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gavel_server/src/generated/dto/convergence_series.dart'
    as _itdczzde;
import 'package:gavel_server/src/generated/dto/event_summary.dart' as _imbo012g;
import 'package:gavel_server/src/generated/project.dart' as _ih65fkic;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'activity_kind.dart' as _ig63m04h;
import 'activity_log.dart' as _ipk33df5;
import 'dto/activity_item.dart' as _i8pa7jax;
import 'dto/announcement.dart' as _i5axqu4j;
import 'dto/convergence_series.dart' as _im621x9e;
import 'dto/event_public_info.dart' as _isydbdbn;
import 'dto/event_summary.dart' as _imueu0ku;
import 'dto/join_result.dart' as _i7qubupk;
import 'dto/judge_state.dart' as _im6wdycs;
import 'dto/judge_summary.dart' as _i1c0yp2k;
import 'dto/landing_stats.dart' as _iid7a7dw;
import 'dto/leaderboard_entry.dart' as _ieq5c8ss;
import 'dto/live_ping.dart' as _i9jx5la6;
import 'dto/live_snapshot.dart' as _ictxmvoc;
import 'dto/note_view.dart' as _ifv24ods;
import 'dto/organizer_event.dart' as _i1lslllp;
import 'dto/project_card.dart' as _i7gchr8b;
import 'dto/project_detail.dart' as _ib4gb2kh;
import 'dto/project_input.dart' as _i7cwf2q4;
import 'dto/public_results.dart' as _irzeonlq;
import 'event.dart' as _iu57571s;
import 'event_organizer.dart' as _i7v7zbfl;
import 'event_status.dart' as _ip80g9gw;
import 'future_calls_generated_models/event_close_future_call_close_judging_model.dart'
    as _i3725xkm;
import 'future_calls_generated_models/simulation_future_call_tick_model.dart'
    as _i763hw1r;
import 'gavel_exception.dart' as _is5966kj;
import 'judge.dart' as _icm5t1sd;
import 'judge_note.dart' as _iprr43l9;
import 'judge_phase.dart' as _ihz61awt;
import 'note_source.dart' as _imwmkxfc;
import 'project.dart' as _ifiazq2p;
import 'score_snapshot.dart' as _is3jsu6x;
import 'skip_reason.dart' as _ixl9rmv8;
import 'visit.dart' as _igsi698m;
import 'visit_outcome.dart' as _iici1ivk;
import 'vote.dart' as _idh2mpcr;
import 'vote_choice.dart' as _ikt0dvae;
export 'activity_kind.dart';
export 'activity_log.dart';
export 'dto/activity_item.dart';
export 'dto/announcement.dart';
export 'dto/convergence_series.dart';
export 'dto/event_public_info.dart';
export 'dto/event_summary.dart';
export 'dto/join_result.dart';
export 'dto/judge_state.dart';
export 'dto/judge_summary.dart';
export 'dto/landing_stats.dart';
export 'dto/leaderboard_entry.dart';
export 'dto/live_ping.dart';
export 'dto/live_snapshot.dart';
export 'dto/note_view.dart';
export 'dto/organizer_event.dart';
export 'dto/project_card.dart';
export 'dto/project_detail.dart';
export 'dto/project_input.dart';
export 'dto/public_results.dart';
export 'event.dart';
export 'event_organizer.dart';
export 'event_status.dart';
export 'gavel_exception.dart';
export 'judge.dart';
export 'judge_note.dart';
export 'judge_phase.dart';
export 'note_source.dart';
export 'project.dart';
export 'score_snapshot.dart';
export 'skip_reason.dart';
export 'visit.dart';
export 'visit_outcome.dart';
export 'vote.dart';
export 'vote_choice.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'activity_log',
      dartName: 'ActivityLog',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ActivityKind',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'activity_log_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'activity_log_event_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event',
      dartName: 'Event',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'tagline',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'slug',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'judgeCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'adminKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EventStatus',
          columnDefault: '\'setup\'',
        ),
        _isp.ColumnDefinition(
          name: 'minViews',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2',
        ),
        _isp.ColumnDefinition(
          name: 'assignmentTimeoutMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '5',
        ),
        _isp.ColumnDefinition(
          name: 'closesAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'resultsPublished',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'isDemo',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'simulationRunning',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'announcementUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'announcementScript',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_slug_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'event_judge_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'judgeCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'event_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event_organizer',
      dartName: 'EventOrganizer',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'event_organizer_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_organizer_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'event_organizer_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'judge',
      dartName: 'Judge',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'token',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'alpha',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '5.0',
        ),
        _isp.ColumnDefinition(
          name: 'beta',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1.0',
        ),
        _isp.ColumnDefinition(
          name: 'active',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'currentProjectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'previousProjectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'assignedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'votesCast',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'skips',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'isSimulated',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'simKind',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'simNextActionAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'lastActiveAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'judge_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'judge_fk_1',
          columns: ['currentProjectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'judge_fk_2',
          columns: ['previousProjectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'judge_event_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'judge_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'judge_note',
      dartName: 'JudgeNote',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'judgeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:NoteSource',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'judge_note_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'judge_note_fk_1',
          columns: ['judgeId'],
          referenceTable: 'judge',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'judge_note_fk_2',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'judge_note_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'project',
      dartName: 'Project',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'team',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'link',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'mu',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _isp.ColumnDefinition(
          name: 'sigmaSq',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1.0',
        ),
        _isp.ColumnDefinition(
          name: 'active',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'prioritized',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'timesSeen',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'absentReports',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'simTrueScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'project_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'project_event_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'score_snapshot',
      dartName: 'ScoreSnapshot',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'mu',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'sigmaSq',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'voteNumber',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'score_snapshot_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'score_snapshot_fk_1',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'score_snapshot_event_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'voteNumber',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'visit',
      dartName: 'Visit',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'judgeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'outcome',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VisitOutcome',
        ),
        _isp.ColumnDefinition(
          name: 'skipReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SkipReason?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'visit_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'visit_fk_1',
          columns: ['judgeId'],
          referenceTable: 'judge',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'visit_fk_2',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'visit_judge_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'judgeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vote',
      dartName: 'Vote',
      schema: 'public',
      module: 'gavel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'judgeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'winnerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'loserId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'vote_fk_0',
          columns: ['eventId'],
          referenceTable: 'event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'vote_fk_1',
          columns: ['judgeId'],
          referenceTable: 'judge',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'vote_fk_2',
          columns: ['winnerId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'vote_fk_3',
          columns: ['loserId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'vote_event_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ig63m04h.ActivityKind) {
      return _ig63m04h.ActivityKind.fromJson(data) as T;
    }
    if (t == _ipk33df5.ActivityLog) {
      return _ipk33df5.ActivityLog.fromJson(data) as T;
    }
    if (t == _i8pa7jax.ActivityItem) {
      return _i8pa7jax.ActivityItem.fromJson(data) as T;
    }
    if (t == _i5axqu4j.Announcement) {
      return _i5axqu4j.Announcement.fromJson(data) as T;
    }
    if (t == _im621x9e.ConvergenceSeries) {
      return _im621x9e.ConvergenceSeries.fromJson(data) as T;
    }
    if (t == _isydbdbn.EventPublicInfo) {
      return _isydbdbn.EventPublicInfo.fromJson(data) as T;
    }
    if (t == _imueu0ku.EventSummary) {
      return _imueu0ku.EventSummary.fromJson(data) as T;
    }
    if (t == _i7qubupk.JoinResult) {
      return _i7qubupk.JoinResult.fromJson(data) as T;
    }
    if (t == _im6wdycs.JudgeState) {
      return _im6wdycs.JudgeState.fromJson(data) as T;
    }
    if (t == _i1c0yp2k.JudgeSummary) {
      return _i1c0yp2k.JudgeSummary.fromJson(data) as T;
    }
    if (t == _iid7a7dw.LandingStats) {
      return _iid7a7dw.LandingStats.fromJson(data) as T;
    }
    if (t == _ieq5c8ss.LeaderboardEntry) {
      return _ieq5c8ss.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _i9jx5la6.LivePing) {
      return _i9jx5la6.LivePing.fromJson(data) as T;
    }
    if (t == _ictxmvoc.LiveSnapshot) {
      return _ictxmvoc.LiveSnapshot.fromJson(data) as T;
    }
    if (t == _ifv24ods.NoteView) {
      return _ifv24ods.NoteView.fromJson(data) as T;
    }
    if (t == _i1lslllp.OrganizerEvent) {
      return _i1lslllp.OrganizerEvent.fromJson(data) as T;
    }
    if (t == _i7gchr8b.ProjectCard) {
      return _i7gchr8b.ProjectCard.fromJson(data) as T;
    }
    if (t == _ib4gb2kh.ProjectDetail) {
      return _ib4gb2kh.ProjectDetail.fromJson(data) as T;
    }
    if (t == _i7cwf2q4.ProjectInput) {
      return _i7cwf2q4.ProjectInput.fromJson(data) as T;
    }
    if (t == _irzeonlq.PublicResults) {
      return _irzeonlq.PublicResults.fromJson(data) as T;
    }
    if (t == _iu57571s.Event) {
      return _iu57571s.Event.fromJson(data) as T;
    }
    if (t == _i7v7zbfl.EventOrganizer) {
      return _i7v7zbfl.EventOrganizer.fromJson(data) as T;
    }
    if (t == _ip80g9gw.EventStatus) {
      return _ip80g9gw.EventStatus.fromJson(data) as T;
    }
    if (t == _i3725xkm.EventCloseFutureCallCloseJudgingModel) {
      return _i3725xkm.EventCloseFutureCallCloseJudgingModel.fromJson(data)
          as T;
    }
    if (t == _i763hw1r.SimulationFutureCallTickModel) {
      return _i763hw1r.SimulationFutureCallTickModel.fromJson(data) as T;
    }
    if (t == _is5966kj.GavelException) {
      return _is5966kj.GavelException.fromJson(data) as T;
    }
    if (t == _icm5t1sd.Judge) {
      return _icm5t1sd.Judge.fromJson(data) as T;
    }
    if (t == _iprr43l9.JudgeNote) {
      return _iprr43l9.JudgeNote.fromJson(data) as T;
    }
    if (t == _ihz61awt.JudgePhase) {
      return _ihz61awt.JudgePhase.fromJson(data) as T;
    }
    if (t == _imwmkxfc.NoteSource) {
      return _imwmkxfc.NoteSource.fromJson(data) as T;
    }
    if (t == _ifiazq2p.Project) {
      return _ifiazq2p.Project.fromJson(data) as T;
    }
    if (t == _is3jsu6x.ScoreSnapshot) {
      return _is3jsu6x.ScoreSnapshot.fromJson(data) as T;
    }
    if (t == _ixl9rmv8.SkipReason) {
      return _ixl9rmv8.SkipReason.fromJson(data) as T;
    }
    if (t == _igsi698m.Visit) {
      return _igsi698m.Visit.fromJson(data) as T;
    }
    if (t == _iici1ivk.VisitOutcome) {
      return _iici1ivk.VisitOutcome.fromJson(data) as T;
    }
    if (t == _idh2mpcr.Vote) {
      return _idh2mpcr.Vote.fromJson(data) as T;
    }
    if (t == _ikt0dvae.VoteChoice) {
      return _ikt0dvae.VoteChoice.fromJson(data) as T;
    }
    if (t == _is.getType<_ig63m04h.ActivityKind?>()) {
      return (data != null ? _ig63m04h.ActivityKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ipk33df5.ActivityLog?>()) {
      return (data != null ? _ipk33df5.ActivityLog.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8pa7jax.ActivityItem?>()) {
      return (data != null ? _i8pa7jax.ActivityItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5axqu4j.Announcement?>()) {
      return (data != null ? _i5axqu4j.Announcement.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_im621x9e.ConvergenceSeries?>()) {
      return (data != null ? _im621x9e.ConvergenceSeries.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isydbdbn.EventPublicInfo?>()) {
      return (data != null ? _isydbdbn.EventPublicInfo.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imueu0ku.EventSummary?>()) {
      return (data != null ? _imueu0ku.EventSummary.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7qubupk.JoinResult?>()) {
      return (data != null ? _i7qubupk.JoinResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_im6wdycs.JudgeState?>()) {
      return (data != null ? _im6wdycs.JudgeState.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1c0yp2k.JudgeSummary?>()) {
      return (data != null ? _i1c0yp2k.JudgeSummary.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iid7a7dw.LandingStats?>()) {
      return (data != null ? _iid7a7dw.LandingStats.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieq5c8ss.LeaderboardEntry?>()) {
      return (data != null ? _ieq5c8ss.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9jx5la6.LivePing?>()) {
      return (data != null ? _i9jx5la6.LivePing.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ictxmvoc.LiveSnapshot?>()) {
      return (data != null ? _ictxmvoc.LiveSnapshot.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifv24ods.NoteView?>()) {
      return (data != null ? _ifv24ods.NoteView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1lslllp.OrganizerEvent?>()) {
      return (data != null ? _i1lslllp.OrganizerEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7gchr8b.ProjectCard?>()) {
      return (data != null ? _i7gchr8b.ProjectCard.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ib4gb2kh.ProjectDetail?>()) {
      return (data != null ? _ib4gb2kh.ProjectDetail.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7cwf2q4.ProjectInput?>()) {
      return (data != null ? _i7cwf2q4.ProjectInput.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irzeonlq.PublicResults?>()) {
      return (data != null ? _irzeonlq.PublicResults.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iu57571s.Event?>()) {
      return (data != null ? _iu57571s.Event.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7v7zbfl.EventOrganizer?>()) {
      return (data != null ? _i7v7zbfl.EventOrganizer.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ip80g9gw.EventStatus?>()) {
      return (data != null ? _ip80g9gw.EventStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3725xkm.EventCloseFutureCallCloseJudgingModel?>()) {
      return (data != null
              ? _i3725xkm.EventCloseFutureCallCloseJudgingModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i763hw1r.SimulationFutureCallTickModel?>()) {
      return (data != null
              ? _i763hw1r.SimulationFutureCallTickModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_is5966kj.GavelException?>()) {
      return (data != null ? _is5966kj.GavelException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icm5t1sd.Judge?>()) {
      return (data != null ? _icm5t1sd.Judge.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iprr43l9.JudgeNote?>()) {
      return (data != null ? _iprr43l9.JudgeNote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihz61awt.JudgePhase?>()) {
      return (data != null ? _ihz61awt.JudgePhase.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imwmkxfc.NoteSource?>()) {
      return (data != null ? _imwmkxfc.NoteSource.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifiazq2p.Project?>()) {
      return (data != null ? _ifiazq2p.Project.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_is3jsu6x.ScoreSnapshot?>()) {
      return (data != null ? _is3jsu6x.ScoreSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixl9rmv8.SkipReason?>()) {
      return (data != null ? _ixl9rmv8.SkipReason.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igsi698m.Visit?>()) {
      return (data != null ? _igsi698m.Visit.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iici1ivk.VisitOutcome?>()) {
      return (data != null ? _iici1ivk.VisitOutcome.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idh2mpcr.Vote?>()) {
      return (data != null ? _idh2mpcr.Vote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikt0dvae.VoteChoice?>()) {
      return (data != null ? _ikt0dvae.VoteChoice.fromJson(data) : null) as T;
    }
    if (t == List<_ieq5c8ss.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_ieq5c8ss.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<double>) {
      return (data as List).map((e) => deserialize<double>(e)).toList() as T;
    }
    if (t == List<_i1c0yp2k.JudgeSummary>) {
      return (data as List)
              .map((e) => deserialize<_i1c0yp2k.JudgeSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i8pa7jax.ActivityItem>) {
      return (data as List)
              .map((e) => deserialize<_i8pa7jax.ActivityItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ifv24ods.NoteView>) {
      return (data as List)
              .map((e) => deserialize<_ifv24ods.NoteView>(e))
              .toList()
          as T;
    }
    if (t == List<_imbo012g.EventSummary>) {
      return (data as List)
              .map((e) => deserialize<_imbo012g.EventSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ih65fkic.Project>) {
      return (data as List)
              .map((e) => deserialize<_ih65fkic.Project>(e))
              .toList()
          as T;
    }
    if (t == List<_itdczzde.ConvergenceSeries>) {
      return (data as List)
              .map((e) => deserialize<_itdczzde.ConvergenceSeries>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ig63m04h.ActivityKind => 'ActivityKind',
      _ipk33df5.ActivityLog => 'ActivityLog',
      _i8pa7jax.ActivityItem => 'ActivityItem',
      _i5axqu4j.Announcement => 'Announcement',
      _im621x9e.ConvergenceSeries => 'ConvergenceSeries',
      _isydbdbn.EventPublicInfo => 'EventPublicInfo',
      _imueu0ku.EventSummary => 'EventSummary',
      _i7qubupk.JoinResult => 'JoinResult',
      _im6wdycs.JudgeState => 'JudgeState',
      _i1c0yp2k.JudgeSummary => 'JudgeSummary',
      _iid7a7dw.LandingStats => 'LandingStats',
      _ieq5c8ss.LeaderboardEntry => 'LeaderboardEntry',
      _i9jx5la6.LivePing => 'LivePing',
      _ictxmvoc.LiveSnapshot => 'LiveSnapshot',
      _ifv24ods.NoteView => 'NoteView',
      _i1lslllp.OrganizerEvent => 'OrganizerEvent',
      _i7gchr8b.ProjectCard => 'ProjectCard',
      _ib4gb2kh.ProjectDetail => 'ProjectDetail',
      _i7cwf2q4.ProjectInput => 'ProjectInput',
      _irzeonlq.PublicResults => 'PublicResults',
      _iu57571s.Event => 'Event',
      _i7v7zbfl.EventOrganizer => 'EventOrganizer',
      _ip80g9gw.EventStatus => 'EventStatus',
      _i3725xkm.EventCloseFutureCallCloseJudgingModel =>
        'EventCloseFutureCallCloseJudgingModel',
      _i763hw1r.SimulationFutureCallTickModel =>
        'SimulationFutureCallTickModel',
      _is5966kj.GavelException => 'GavelException',
      _icm5t1sd.Judge => 'Judge',
      _iprr43l9.JudgeNote => 'JudgeNote',
      _ihz61awt.JudgePhase => 'JudgePhase',
      _imwmkxfc.NoteSource => 'NoteSource',
      _ifiazq2p.Project => 'Project',
      _is3jsu6x.ScoreSnapshot => 'ScoreSnapshot',
      _ixl9rmv8.SkipReason => 'SkipReason',
      _igsi698m.Visit => 'Visit',
      _iici1ivk.VisitOutcome => 'VisitOutcome',
      _idh2mpcr.Vote => 'Vote',
      _ikt0dvae.VoteChoice => 'VoteChoice',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('gavel.', '');
    }

    switch (data) {
      case _ig63m04h.ActivityKind():
        return 'ActivityKind';
      case _ipk33df5.ActivityLog():
        return 'ActivityLog';
      case _i8pa7jax.ActivityItem():
        return 'ActivityItem';
      case _i5axqu4j.Announcement():
        return 'Announcement';
      case _im621x9e.ConvergenceSeries():
        return 'ConvergenceSeries';
      case _isydbdbn.EventPublicInfo():
        return 'EventPublicInfo';
      case _imueu0ku.EventSummary():
        return 'EventSummary';
      case _i7qubupk.JoinResult():
        return 'JoinResult';
      case _im6wdycs.JudgeState():
        return 'JudgeState';
      case _i1c0yp2k.JudgeSummary():
        return 'JudgeSummary';
      case _iid7a7dw.LandingStats():
        return 'LandingStats';
      case _ieq5c8ss.LeaderboardEntry():
        return 'LeaderboardEntry';
      case _i9jx5la6.LivePing():
        return 'LivePing';
      case _ictxmvoc.LiveSnapshot():
        return 'LiveSnapshot';
      case _ifv24ods.NoteView():
        return 'NoteView';
      case _i1lslllp.OrganizerEvent():
        return 'OrganizerEvent';
      case _i7gchr8b.ProjectCard():
        return 'ProjectCard';
      case _ib4gb2kh.ProjectDetail():
        return 'ProjectDetail';
      case _i7cwf2q4.ProjectInput():
        return 'ProjectInput';
      case _irzeonlq.PublicResults():
        return 'PublicResults';
      case _iu57571s.Event():
        return 'Event';
      case _i7v7zbfl.EventOrganizer():
        return 'EventOrganizer';
      case _ip80g9gw.EventStatus():
        return 'EventStatus';
      case _i3725xkm.EventCloseFutureCallCloseJudgingModel():
        return 'EventCloseFutureCallCloseJudgingModel';
      case _i763hw1r.SimulationFutureCallTickModel():
        return 'SimulationFutureCallTickModel';
      case _is5966kj.GavelException():
        return 'GavelException';
      case _icm5t1sd.Judge():
        return 'Judge';
      case _iprr43l9.JudgeNote():
        return 'JudgeNote';
      case _ihz61awt.JudgePhase():
        return 'JudgePhase';
      case _imwmkxfc.NoteSource():
        return 'NoteSource';
      case _ifiazq2p.Project():
        return 'Project';
      case _is3jsu6x.ScoreSnapshot():
        return 'ScoreSnapshot';
      case _ixl9rmv8.SkipReason():
        return 'SkipReason';
      case _igsi698m.Visit():
        return 'Visit';
      case _iici1ivk.VisitOutcome():
        return 'VisitOutcome';
      case _idh2mpcr.Vote():
        return 'Vote';
      case _ikt0dvae.VoteChoice():
        return 'VoteChoice';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActivityKind') {
      return deserialize<_ig63m04h.ActivityKind>(data['data']);
    }
    if (dataClassName == 'ActivityLog') {
      return deserialize<_ipk33df5.ActivityLog>(data['data']);
    }
    if (dataClassName == 'ActivityItem') {
      return deserialize<_i8pa7jax.ActivityItem>(data['data']);
    }
    if (dataClassName == 'Announcement') {
      return deserialize<_i5axqu4j.Announcement>(data['data']);
    }
    if (dataClassName == 'ConvergenceSeries') {
      return deserialize<_im621x9e.ConvergenceSeries>(data['data']);
    }
    if (dataClassName == 'EventPublicInfo') {
      return deserialize<_isydbdbn.EventPublicInfo>(data['data']);
    }
    if (dataClassName == 'EventSummary') {
      return deserialize<_imueu0ku.EventSummary>(data['data']);
    }
    if (dataClassName == 'JoinResult') {
      return deserialize<_i7qubupk.JoinResult>(data['data']);
    }
    if (dataClassName == 'JudgeState') {
      return deserialize<_im6wdycs.JudgeState>(data['data']);
    }
    if (dataClassName == 'JudgeSummary') {
      return deserialize<_i1c0yp2k.JudgeSummary>(data['data']);
    }
    if (dataClassName == 'LandingStats') {
      return deserialize<_iid7a7dw.LandingStats>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_ieq5c8ss.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'LivePing') {
      return deserialize<_i9jx5la6.LivePing>(data['data']);
    }
    if (dataClassName == 'LiveSnapshot') {
      return deserialize<_ictxmvoc.LiveSnapshot>(data['data']);
    }
    if (dataClassName == 'NoteView') {
      return deserialize<_ifv24ods.NoteView>(data['data']);
    }
    if (dataClassName == 'OrganizerEvent') {
      return deserialize<_i1lslllp.OrganizerEvent>(data['data']);
    }
    if (dataClassName == 'ProjectCard') {
      return deserialize<_i7gchr8b.ProjectCard>(data['data']);
    }
    if (dataClassName == 'ProjectDetail') {
      return deserialize<_ib4gb2kh.ProjectDetail>(data['data']);
    }
    if (dataClassName == 'ProjectInput') {
      return deserialize<_i7cwf2q4.ProjectInput>(data['data']);
    }
    if (dataClassName == 'PublicResults') {
      return deserialize<_irzeonlq.PublicResults>(data['data']);
    }
    if (dataClassName == 'Event') {
      return deserialize<_iu57571s.Event>(data['data']);
    }
    if (dataClassName == 'EventOrganizer') {
      return deserialize<_i7v7zbfl.EventOrganizer>(data['data']);
    }
    if (dataClassName == 'EventStatus') {
      return deserialize<_ip80g9gw.EventStatus>(data['data']);
    }
    if (dataClassName == 'EventCloseFutureCallCloseJudgingModel') {
      return deserialize<_i3725xkm.EventCloseFutureCallCloseJudgingModel>(
        data['data'],
      );
    }
    if (dataClassName == 'SimulationFutureCallTickModel') {
      return deserialize<_i763hw1r.SimulationFutureCallTickModel>(data['data']);
    }
    if (dataClassName == 'GavelException') {
      return deserialize<_is5966kj.GavelException>(data['data']);
    }
    if (dataClassName == 'Judge') {
      return deserialize<_icm5t1sd.Judge>(data['data']);
    }
    if (dataClassName == 'JudgeNote') {
      return deserialize<_iprr43l9.JudgeNote>(data['data']);
    }
    if (dataClassName == 'JudgePhase') {
      return deserialize<_ihz61awt.JudgePhase>(data['data']);
    }
    if (dataClassName == 'NoteSource') {
      return deserialize<_imwmkxfc.NoteSource>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_ifiazq2p.Project>(data['data']);
    }
    if (dataClassName == 'ScoreSnapshot') {
      return deserialize<_is3jsu6x.ScoreSnapshot>(data['data']);
    }
    if (dataClassName == 'SkipReason') {
      return deserialize<_ixl9rmv8.SkipReason>(data['data']);
    }
    if (dataClassName == 'Visit') {
      return deserialize<_igsi698m.Visit>(data['data']);
    }
    if (dataClassName == 'VisitOutcome') {
      return deserialize<_iici1ivk.VisitOutcome>(data['data']);
    }
    if (dataClassName == 'Vote') {
      return deserialize<_idh2mpcr.Vote>(data['data']);
    }
    if (dataClassName == 'VoteChoice') {
      return deserialize<_ikt0dvae.VoteChoice>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('gavel', this);
    _iacs.Protocol().registerHostProtocol('gavel', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ipk33df5.ActivityLog:
        return _ipk33df5.ActivityLog.t;
      case _iu57571s.Event:
        return _iu57571s.Event.t;
      case _i7v7zbfl.EventOrganizer:
        return _i7v7zbfl.EventOrganizer.t;
      case _icm5t1sd.Judge:
        return _icm5t1sd.Judge.t;
      case _iprr43l9.JudgeNote:
        return _iprr43l9.JudgeNote.t;
      case _ifiazq2p.Project:
        return _ifiazq2p.Project.t;
      case _is3jsu6x.ScoreSnapshot:
        return _is3jsu6x.ScoreSnapshot.t;
      case _igsi698m.Visit:
        return _igsi698m.Visit.t;
      case _idh2mpcr.Vote:
        return _idh2mpcr.Vote.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'gavel';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
