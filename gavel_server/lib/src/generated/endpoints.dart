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
import 'dart:typed_data' as _idt;
import 'package:gavel_server/src/generated/dto/project_input.dart' as _i69enwdb;
import 'package:gavel_server/src/generated/event_status.dart' as _il2f3kha;
import 'package:gavel_server/src/generated/future_calls.dart' as _ixqh6y26;
import 'package:gavel_server/src/generated/skip_reason.dart' as _ijee2m0x;
import 'package:gavel_server/src/generated/vote_choice.dart' as _igw1z1oe;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/anonymous_idp_endpoint.dart' as _in0zita6;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/judge_endpoint.dart' as _iolgfhr8;
import '../endpoints/organizer_endpoint.dart' as _iqabi5q3;
import '../endpoints/results_endpoint.dart' as _ifcmru73;
import '../endpoints/voice_endpoint.dart' as _iq0gswfc;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'anonymousIdp': _in0zita6.AnonymousIdpEndpoint()
        ..initialize(
          server,
          'anonymousIdp',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'judge': _iolgfhr8.JudgeEndpoint()
        ..initialize(
          server,
          'judge',
          null,
        ),
      'organizer': _iqabi5q3.OrganizerEndpoint()
        ..initialize(
          server,
          'organizer',
          null,
        ),
      'results': _ifcmru73.ResultsEndpoint()
        ..initialize(
          server,
          'results',
          null,
        ),
      'voice': _iq0gswfc.VoiceEndpoint()
        ..initialize(
          server,
          'voice',
          null,
        ),
    };
    connectors['anonymousIdp'] = _is.EndpointConnector(
      name: 'anonymousIdp',
      endpoint: endpoints['anonymousIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['anonymousIdp'] as _in0zita6.AnonymousIdpEndpoint)
                      .login(
                        session,
                        token: params['token'],
                      ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['judge'] = _is.EndpointConnector(
      name: 'judge',
      endpoint: endpoints['judge']!,
      methodConnectors: {
        'lookup': _is.MethodConnector(
          name: 'lookup',
          params: {
            'judgeCode': _is.ParameterDescription(
              name: 'judgeCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).lookup(
                session,
                params['judgeCode'],
              ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'judgeCode': _is.ParameterDescription(
              name: 'judgeCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).join(
                session,
                params['judgeCode'],
                params['name'],
              ),
        ),
        'state': _is.MethodConnector(
          name: 'state',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).state(
                session,
                params['token'],
              ),
        ),
        'begin': _is.MethodConnector(
          name: 'begin',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).begin(
                session,
                params['token'],
              ),
        ),
        'finishFirstVisit': _is.MethodConnector(
          name: 'finishFirstVisit',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint)
                  .finishFirstVisit(
                    session,
                    params['token'],
                  ),
        ),
        'vote': _is.MethodConnector(
          name: 'vote',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'choice': _is.ParameterDescription(
              name: 'choice',
              type: _is.getType<_igw1z1oe.VoteChoice>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).vote(
                session,
                params['token'],
                params['choice'],
              ),
        ),
        'skip': _is.MethodConnector(
          name: 'skip',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<_ijee2m0x.SkipReason>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).skip(
                session,
                params['token'],
                params['reason'],
              ),
        ),
        'addNote': _is.MethodConnector(
          name: 'addNote',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).addNote(
                    session,
                    params['token'],
                    params['projectId'],
                    params['text'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['judge'] as _iolgfhr8.JudgeEndpoint).watch(
                session,
                params['token'],
              ),
        ),
      },
    );
    connectors['organizer'] = _is.EndpointConnector(
      name: 'organizer',
      endpoint: endpoints['organizer']!,
      methodConnectors: {
        'createEvent': _is.MethodConnector(
          name: 'createEvent',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'tagline': _is.ParameterDescription(
              name: 'tagline',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .createEvent(
                    session,
                    params['name'],
                    params['tagline'],
                  ),
        ),
        'createDemoEvent': _is.MethodConnector(
          name: 'createDemoEvent',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .createDemoEvent(session),
        ),
        'myEvents': _is.MethodConnector(
          name: 'myEvents',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .myEvents(session),
        ),
        'getEvent': _is.MethodConnector(
          name: 'getEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .getEvent(
                    session,
                    params['eventId'],
                  ),
        ),
        'claimEvent': _is.MethodConnector(
          name: 'claimEvent',
          params: {
            'adminKey': _is.ParameterDescription(
              name: 'adminKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .claimEvent(
                    session,
                    params['adminKey'],
                  ),
        ),
        'updateEvent': _is.MethodConnector(
          name: 'updateEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'tagline': _is.ParameterDescription(
              name: 'tagline',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'minViews': _is.ParameterDescription(
              name: 'minViews',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .updateEvent(
                    session,
                    params['eventId'],
                    params['name'],
                    params['tagline'],
                    params['minViews'],
                  ),
        ),
        'setStatus': _is.MethodConnector(
          name: 'setStatus',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_il2f3kha.EventStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .setStatus(
                    session,
                    params['eventId'],
                    params['status'],
                  ),
        ),
        'scheduleClose': _is.MethodConnector(
          name: 'scheduleClose',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'closesAt': _is.ParameterDescription(
              name: 'closesAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .scheduleClose(
                    session,
                    params['eventId'],
                    params['closesAt'],
                  ),
        ),
        'publishResults': _is.MethodConnector(
          name: 'publishResults',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'published': _is.ParameterDescription(
              name: 'published',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .publishResults(
                    session,
                    params['eventId'],
                    params['published'],
                  ),
        ),
        'deleteEvent': _is.MethodConnector(
          name: 'deleteEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .deleteEvent(
                    session,
                    params['eventId'],
                  ),
        ),
        'projects': _is.MethodConnector(
          name: 'projects',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .projects(
                    session,
                    params['eventId'],
                  ),
        ),
        'addProject': _is.MethodConnector(
          name: 'addProject',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_i69enwdb.ProjectInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .addProject(
                    session,
                    params['eventId'],
                    params['input'],
                  ),
        ),
        'importProjects': _is.MethodConnector(
          name: 'importProjects',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'csv': _is.ParameterDescription(
              name: 'csv',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .importProjects(
                    session,
                    params['eventId'],
                    params['csv'],
                  ),
        ),
        'updateProject': _is.MethodConnector(
          name: 'updateProject',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_i69enwdb.ProjectInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .updateProject(
                    session,
                    params['projectId'],
                    params['input'],
                  ),
        ),
        'setProjectActive': _is.MethodConnector(
          name: 'setProjectActive',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'active': _is.ParameterDescription(
              name: 'active',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .setProjectActive(
                    session,
                    params['projectId'],
                    params['active'],
                  ),
        ),
        'setProjectPrioritized': _is.MethodConnector(
          name: 'setProjectPrioritized',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'prioritized': _is.ParameterDescription(
              name: 'prioritized',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .setProjectPrioritized(
                    session,
                    params['projectId'],
                    params['prioritized'],
                  ),
        ),
        'deleteProject': _is.MethodConnector(
          name: 'deleteProject',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .deleteProject(
                    session,
                    params['projectId'],
                  ),
        ),
        'projectDetail': _is.MethodConnector(
          name: 'projectDetail',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .projectDetail(
                    session,
                    params['projectId'],
                  ),
        ),
        'addJudge': _is.MethodConnector(
          name: 'addJudge',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .addJudge(
                    session,
                    params['eventId'],
                    params['name'],
                  ),
        ),
        'judgeLink': _is.MethodConnector(
          name: 'judgeLink',
          params: {
            'judgeId': _is.ParameterDescription(
              name: 'judgeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .judgeLink(
                    session,
                    params['judgeId'],
                  ),
        ),
        'setJudgeActive': _is.MethodConnector(
          name: 'setJudgeActive',
          params: {
            'judgeId': _is.ParameterDescription(
              name: 'judgeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'active': _is.ParameterDescription(
              name: 'active',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .setJudgeActive(
                    session,
                    params['judgeId'],
                    params['active'],
                  ),
        ),
        'startSimulation': _is.MethodConnector(
          name: 'startSimulation',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'judgeCount': _is.ParameterDescription(
              name: 'judgeCount',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .startSimulation(
                    session,
                    params['eventId'],
                    params['judgeCount'],
                  ),
        ),
        'stopSimulation': _is.MethodConnector(
          name: 'stopSimulation',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .stopSimulation(
                    session,
                    params['eventId'],
                  ),
        ),
        'snapshot': _is.MethodConnector(
          name: 'snapshot',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .snapshot(
                    session,
                    params['eventId'],
                  ),
        ),
        'convergence': _is.MethodConnector(
          name: 'convergence',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .convergence(
                    session,
                    params['eventId'],
                  ),
        ),
        'announceWinners': _is.MethodConnector(
          name: 'announceWinners',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .announceWinners(
                    session,
                    params['eventId'],
                  ),
        ),
        'exportCsv': _is.MethodConnector(
          name: 'exportCsv',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint)
                  .exportCsv(
                    session,
                    params['eventId'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) =>
                  (endpoints['organizer'] as _iqabi5q3.OrganizerEndpoint).watch(
                    session,
                    params['eventId'],
                  ),
        ),
      },
    );
    connectors['results'] = _is.EndpointConnector(
      name: 'results',
      endpoint: endpoints['results']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'slug': _is.ParameterDescription(
              name: 'slug',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['results'] as _ifcmru73.ResultsEndpoint).get(
                    session,
                    params['slug'],
                  ),
        ),
      },
    );
    connectors['voice'] = _is.EndpointConnector(
      name: 'voice',
      endpoint: endpoints['voice']!,
      methodConnectors: {
        'available': _is.MethodConnector(
          name: 'available',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voice'] as _iq0gswfc.VoiceEndpoint)
                  .available(session),
        ),
        'transcribeNote': _is.MethodConnector(
          name: 'transcribeNote',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'audio': _is.ParameterDescription(
              name: 'audio',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
            'mimeType': _is.ParameterDescription(
              name: 'mimeType',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voice'] as _iq0gswfc.VoiceEndpoint)
                  .transcribeNote(
                    session,
                    params['token'],
                    params['projectId'],
                    params['audio'],
                    params['mimeType'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ixqh6y26.FutureCalls();
  }
}
