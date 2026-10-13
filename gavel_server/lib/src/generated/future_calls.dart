/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../future_calls/event_close_future_call.dart' as _ipvcxnyg;
import '../future_calls/maintenance_future_call.dart' as _inccg6wr;
import '../future_calls/simulation_future_call.dart' as _irsyu3yf;
import 'future_calls_generated_models/event_close_future_call_close_judging_model.dart'
    as _i3725xkm;
import 'future_calls_generated_models/simulation_future_call_tick_model.dart'
    as _i763hw1r;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'EventCloseCloseJudgingFutureCall': EventCloseCloseJudgingFutureCall(),
      'MaintenanceSweepFutureCall': MaintenanceSweepFutureCall(),
      'SimulationTickFutureCall': SimulationTickFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final eventClose = _EventCloseFutureCallDispatcher(_invokeFutureCall);

  late final maintenance = _MaintenanceFutureCallDispatcher(_invokeFutureCall);

  late final simulation = _SimulationFutureCallDispatcher(_invokeFutureCall);
}

class _EventCloseFutureCallDispatcher {
  _EventCloseFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> closeJudging(int eventId) {
    var object = _i3725xkm.EventCloseFutureCallCloseJudgingModel(
      eventId: eventId,
    );
    return _invokeFutureCall(
      'EventCloseCloseJudgingFutureCall',
      object,
    );
  }
}

class _MaintenanceFutureCallDispatcher {
  _MaintenanceFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> sweep() {
    return _invokeFutureCall(
      'MaintenanceSweepFutureCall',
      null,
    );
  }
}

class _SimulationFutureCallDispatcher {
  _SimulationFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> tick(int eventId) {
    var object = _i763hw1r.SimulationFutureCallTickModel(eventId: eventId);
    return _invokeFutureCall(
      'SimulationTickFutureCall',
      object,
    );
  }
}

class EventCloseCloseJudgingFutureCall
    extends _is.FutureCall<_i3725xkm.EventCloseFutureCallCloseJudgingModel>
    implements
        _is.InvokableFutureCall<
          _i3725xkm.EventCloseFutureCallCloseJudgingModel
        > {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _i3725xkm.EventCloseFutureCallCloseJudgingModel? object,
  ) async {
    if (object != null) {
      await _ipvcxnyg.EventCloseFutureCall().closeJudging(
        session,
        object.eventId,
      );
    }
  }
}

class MaintenanceSweepFutureCall extends _is.FutureCall
    implements _is.InvokableFutureCall {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _is.SerializableModel? object,
  ) async {
    await _inccg6wr.MaintenanceFutureCall().sweep(session);
  }
}

class SimulationTickFutureCall
    extends _is.FutureCall<_i763hw1r.SimulationFutureCallTickModel>
    implements
        _is.InvokableFutureCall<_i763hw1r.SimulationFutureCallTickModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _i763hw1r.SimulationFutureCallTickModel? object,
  ) async {
    if (object != null) {
      await _irsyu3yf.SimulationFutureCall().tick(
        session,
        object.eventId,
      );
    }
  }
}
