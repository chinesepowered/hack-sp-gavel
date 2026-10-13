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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:gavel_client/src/protocol/dto/announcement.dart' as _iex56o3e;
import 'package:gavel_client/src/protocol/dto/convergence_series.dart'
    as _iy7dg72r;
import 'package:gavel_client/src/protocol/dto/event_public_info.dart'
    as _ivakq6t5;
import 'package:gavel_client/src/protocol/dto/event_summary.dart' as _izjbr24v;
import 'package:gavel_client/src/protocol/dto/join_result.dart' as _ioiq72a2;
import 'package:gavel_client/src/protocol/dto/judge_state.dart' as _i6w19yni;
import 'package:gavel_client/src/protocol/dto/live_snapshot.dart' as _ijip32kh;
import 'package:gavel_client/src/protocol/dto/note_view.dart' as _iyofihcj;
import 'package:gavel_client/src/protocol/dto/organizer_event.dart'
    as _i09cpizr;
import 'package:gavel_client/src/protocol/dto/project_detail.dart' as _ihxfa21d;
import 'package:gavel_client/src/protocol/dto/project_input.dart' as _imeaem2h;
import 'package:gavel_client/src/protocol/dto/public_results.dart' as _iu33zgkw;
import 'package:gavel_client/src/protocol/event_status.dart' as _if6ynqoz;
import 'package:gavel_client/src/protocol/project.dart' as _iio1d0at;
import 'package:gavel_client/src/protocol/skip_reason.dart' as _itynp5pn;
import 'package:gavel_client/src/protocol/vote_choice.dart' as _imu2s53u;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Lets organizers start instantly with an anonymous account
/// ("Continue without account"), alongside email sign-in.
/// {@category Endpoint}
class EndpointAnonymousIdp extends _iaic.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _ida.Future<_iacc.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The judge's phone. Judges never create an account: every call carries the
/// secret token from their personal magic link.
/// {@category Endpoint}
class EndpointJudge extends _isc.EndpointRef {
  EndpointJudge(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'judge';

  /// Public info for the join screen.
  _ida.Future<_ivakq6t5.EventPublicInfo> lookup(String judgeCode) =>
      caller.callServerEndpoint<_ivakq6t5.EventPublicInfo>(
        'judge',
        'lookup',
        {'judgeCode': judgeCode},
      );

  /// Self-service join from the event QR code / judge code.
  _ida.Future<_ioiq72a2.JoinResult> join(
    String judgeCode,
    String name,
  ) => caller.callServerEndpoint<_ioiq72a2.JoinResult>(
    'judge',
    'join',
    {
      'judgeCode': judgeCode,
      'name': name,
    },
  );

  _ida.Future<_i6w19yni.JudgeState> state(String token) =>
      caller.callServerEndpoint<_i6w19yni.JudgeState>(
        'judge',
        'state',
        {'token': token},
      );

  /// Starts judging (or checks for newly available projects).
  _ida.Future<_i6w19yni.JudgeState> begin(String token) =>
      caller.callServerEndpoint<_i6w19yni.JudgeState>(
        'judge',
        'begin',
        {'token': token},
      );

  /// Done with the first project: there is nothing to compare it with yet.
  _ida.Future<_i6w19yni.JudgeState> finishFirstVisit(String token) =>
      caller.callServerEndpoint<_i6w19yni.JudgeState>(
        'judge',
        'finishFirstVisit',
        {'token': token},
      );

  /// Was the current project better than the previous one?
  _ida.Future<_i6w19yni.JudgeState> vote(
    String token,
    _imu2s53u.VoteChoice choice,
  ) => caller.callServerEndpoint<_i6w19yni.JudgeState>(
    'judge',
    'vote',
    {
      'token': token,
      'choice': choice,
    },
  );

  _ida.Future<_i6w19yni.JudgeState> skip(
    String token,
    _itynp5pn.SkipReason reason,
  ) => caller.callServerEndpoint<_i6w19yni.JudgeState>(
    'judge',
    'skip',
    {
      'token': token,
      'reason': reason,
    },
  );

  /// A typed note about a project the judge has seen or is visiting.
  _ida.Future<_iyofihcj.NoteView> addNote(
    String token,
    int projectId,
    String text,
  ) => caller.callServerEndpoint<_iyofihcj.NoteView>(
    'judge',
    'addNote',
    {
      'token': token,
      'projectId': projectId,
      'text': text,
    },
  );

  /// Pushes a fresh state whenever the server re-routes this judge (project
  /// paused, event opened or closed, seat paused by an organizer).
  _ida.Stream<_i6w19yni.JudgeState> watch(String token) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i6w19yni.JudgeState>,
        _i6w19yni.JudgeState
      >(
        'judge',
        'watch',
        {'token': token},
        {},
      );
}

/// Everything an organizer does: events, projects, judges, live dashboard.
///
/// Requires a signed-in user (email or anonymous account).
/// {@category Endpoint}
class EndpointOrganizer extends _isc.EndpointRef {
  EndpointOrganizer(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organizer';

  _ida.Future<_i09cpizr.OrganizerEvent> createEvent(
    String name,
    String? tagline,
  ) => caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
    'organizer',
    'createEvent',
    {
      'name': name,
      'tagline': tagline,
    },
  );

  /// Creates a sandbox event with 24 sample projects, ready to simulate.
  _ida.Future<_i09cpizr.OrganizerEvent> createDemoEvent() =>
      caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
        'organizer',
        'createDemoEvent',
        {},
      );

  _ida.Future<List<_izjbr24v.EventSummary>> myEvents() =>
      caller.callServerEndpoint<List<_izjbr24v.EventSummary>>(
        'organizer',
        'myEvents',
        {},
      );

  _ida.Future<_i09cpizr.OrganizerEvent> getEvent(int eventId) =>
      caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
        'organizer',
        'getEvent',
        {'eventId': eventId},
      );

  /// Joins an event as co-organizer using its admin link.
  _ida.Future<_i09cpizr.OrganizerEvent> claimEvent(String adminKey) =>
      caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
        'organizer',
        'claimEvent',
        {'adminKey': adminKey},
      );

  _ida.Future<_i09cpizr.OrganizerEvent> updateEvent(
    int eventId,
    String name,
    String? tagline,
    int minViews,
  ) => caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
    'organizer',
    'updateEvent',
    {
      'eventId': eventId,
      'name': name,
      'tagline': tagline,
      'minViews': minViews,
    },
  );

  _ida.Future<_i09cpizr.OrganizerEvent> setStatus(
    int eventId,
    _if6ynqoz.EventStatus status,
  ) => caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
    'organizer',
    'setStatus',
    {
      'eventId': eventId,
      'status': status,
    },
  );

  /// Schedules judging to close automatically (a persisted future call).
  /// Pass `null` to cancel.
  _ida.Future<_i09cpizr.OrganizerEvent> scheduleClose(
    int eventId,
    DateTime? closesAt,
  ) => caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
    'organizer',
    'scheduleClose',
    {
      'eventId': eventId,
      'closesAt': closesAt,
    },
  );

  _ida.Future<_i09cpizr.OrganizerEvent> publishResults(
    int eventId,
    bool published,
  ) => caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
    'organizer',
    'publishResults',
    {
      'eventId': eventId,
      'published': published,
    },
  );

  _ida.Future<void> deleteEvent(int eventId) => caller.callServerEndpoint<void>(
    'organizer',
    'deleteEvent',
    {'eventId': eventId},
  );

  _ida.Future<List<_iio1d0at.Project>> projects(int eventId) =>
      caller.callServerEndpoint<List<_iio1d0at.Project>>(
        'organizer',
        'projects',
        {'eventId': eventId},
      );

  _ida.Future<_iio1d0at.Project> addProject(
    int eventId,
    _imeaem2h.ProjectInput input,
  ) => caller.callServerEndpoint<_iio1d0at.Project>(
    'organizer',
    'addProject',
    {
      'eventId': eventId,
      'input': input,
    },
  );

  /// Imports projects from CSV text (`name, location, team, description,
  /// link`). Returns the number of projects created.
  _ida.Future<int> importProjects(
    int eventId,
    String csv,
  ) => caller.callServerEndpoint<int>(
    'organizer',
    'importProjects',
    {
      'eventId': eventId,
      'csv': csv,
    },
  );

  _ida.Future<_iio1d0at.Project> updateProject(
    int projectId,
    _imeaem2h.ProjectInput input,
  ) => caller.callServerEndpoint<_iio1d0at.Project>(
    'organizer',
    'updateProject',
    {
      'projectId': projectId,
      'input': input,
    },
  );

  /// Pauses or resumes a project. Judges walking to a paused project are
  /// re-routed instantly over their live connection.
  _ida.Future<_iio1d0at.Project> setProjectActive(
    int projectId,
    bool active,
  ) => caller.callServerEndpoint<_iio1d0at.Project>(
    'organizer',
    'setProjectActive',
    {
      'projectId': projectId,
      'active': active,
    },
  );

  _ida.Future<_iio1d0at.Project> setProjectPrioritized(
    int projectId,
    bool prioritized,
  ) => caller.callServerEndpoint<_iio1d0at.Project>(
    'organizer',
    'setProjectPrioritized',
    {
      'projectId': projectId,
      'prioritized': prioritized,
    },
  );

  _ida.Future<void> deleteProject(int projectId) =>
      caller.callServerEndpoint<void>(
        'organizer',
        'deleteProject',
        {'projectId': projectId},
      );

  _ida.Future<_ihxfa21d.ProjectDetail> projectDetail(int projectId) =>
      caller.callServerEndpoint<_ihxfa21d.ProjectDetail>(
        'organizer',
        'projectDetail',
        {'projectId': projectId},
      );

  /// Pre-registers a judge and returns the secret token for their magic link.
  _ida.Future<String> addJudge(
    int eventId,
    String name,
  ) => caller.callServerEndpoint<String>(
    'organizer',
    'addJudge',
    {
      'eventId': eventId,
      'name': name,
    },
  );

  /// The magic-link token of an existing judge (to re-share it).
  _ida.Future<String> judgeLink(int judgeId) =>
      caller.callServerEndpoint<String>(
        'organizer',
        'judgeLink',
        {'judgeId': judgeId},
      );

  _ida.Future<void> setJudgeActive(
    int judgeId,
    bool active,
  ) => caller.callServerEndpoint<void>(
    'organizer',
    'setJudgeActive',
    {
      'judgeId': judgeId,
      'active': active,
    },
  );

  _ida.Future<_i09cpizr.OrganizerEvent> startSimulation(
    int eventId,
    int judgeCount,
  ) => caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
    'organizer',
    'startSimulation',
    {
      'eventId': eventId,
      'judgeCount': judgeCount,
    },
  );

  _ida.Future<_i09cpizr.OrganizerEvent> stopSimulation(int eventId) =>
      caller.callServerEndpoint<_i09cpizr.OrganizerEvent>(
        'organizer',
        'stopSimulation',
        {'eventId': eventId},
      );

  /// Live dashboard: a full snapshot now, then a fresh one whenever votes,
  /// skips, joins or organizer actions happen (server events + streaming).
  _ida.Stream<_ijip32kh.LiveSnapshot> watch(int eventId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ijip32kh.LiveSnapshot>,
        _ijip32kh.LiveSnapshot
      >(
        'organizer',
        'watch',
        {'eventId': eventId},
        {},
      );

  _ida.Future<_ijip32kh.LiveSnapshot> snapshot(int eventId) =>
      caller.callServerEndpoint<_ijip32kh.LiveSnapshot>(
        'organizer',
        'snapshot',
        {'eventId': eventId},
      );

  _ida.Future<List<_iy7dg72r.ConvergenceSeries>> convergence(int eventId) =>
      caller.callServerEndpoint<List<_iy7dg72r.ConvergenceSeries>>(
        'organizer',
        'convergence',
        {'eventId': eventId},
      );

  /// Builds the awards ceremony: podium + script narrated by ElevenLabs.
  _ida.Future<_iex56o3e.Announcement> announceWinners(int eventId) =>
      caller.callServerEndpoint<_iex56o3e.Announcement>(
        'organizer',
        'announceWinners',
        {'eventId': eventId},
      );

  _ida.Future<String> exportCsv(int eventId) =>
      caller.callServerEndpoint<String>(
        'organizer',
        'exportCsv',
        {'eventId': eventId},
      );
}

/// Public, read-only results (only once an organizer publishes them).
/// {@category Endpoint}
class EndpointResults extends _isc.EndpointRef {
  EndpointResults(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'results';

  _ida.Future<_iu33zgkw.PublicResults> get(String slug) =>
      caller.callServerEndpoint<_iu33zgkw.PublicResults>(
        'results',
        'get',
        {'slug': slug},
      );
}

/// Voice features powered by ElevenLabs. The API key stays on the server.
/// {@category Endpoint}
class EndpointVoice extends _isc.EndpointRef {
  EndpointVoice(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'voice';

  /// Whether voice features are configured on this server.
  _ida.Future<bool> available() => caller.callServerEndpoint<bool>(
    'voice',
    'available',
    {},
  );

  /// A judge dictates a note on their phone; ElevenLabs Scribe turns it into
  /// text that organizers see next to the project.
  _ida.Future<_iyofihcj.NoteView> transcribeNote(
    String token,
    int projectId,
    _idt.ByteData audio,
    String mimeType,
  ) => caller.callServerEndpoint<_iyofihcj.NoteView>(
    'voice',
    'transcribeNote',
    {
      'token': token,
      'projectId': projectId,
      'audio': audio,
      'mimeType': mimeType,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    anonymousIdp = EndpointAnonymousIdp(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    judge = EndpointJudge(this);
    organizer = EndpointOrganizer(this);
    results = EndpointResults(this);
    voice = EndpointVoice(this);
    modules = Modules(this);
  }

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointJudge judge;

  late final EndpointOrganizer organizer;

  late final EndpointResults results;

  late final EndpointVoice voice;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'anonymousIdp': anonymousIdp,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'judge': judge,
    'organizer': organizer,
    'results': results,
    'voice': voice,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
