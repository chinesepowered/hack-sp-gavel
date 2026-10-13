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
import 'package:gavel_client/src/protocol/protocol.dart' as _ivmqq51r;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dto/judge_state.dart' as _ie092xer;

abstract class JoinResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JoinResult._({
    required this.token,
    required this.state,
  });

  factory JoinResult({
    required String token,
    required _ie092xer.JudgeState state,
  }) = _JoinResultImpl;

  factory JoinResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return JoinResult(
      token: jsonSerialization['token'] as String,
      state: _ivmqq51r.Protocol().deserialize<_ie092xer.JudgeState>(
        jsonSerialization['state'],
      ),
    );
  }

  String token;

  _ie092xer.JudgeState state;

  /// Returns a shallow copy of this [JoinResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JoinResult copyWith({
    String? token,
    _ie092xer.JudgeState? state,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JoinResult',
      'token': token,
      'state': state.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JoinResult',
      'token': token,
      'state': state.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _JoinResultImpl extends JoinResult {
  _JoinResultImpl({
    required String token,
    required _ie092xer.JudgeState state,
  }) : super._(
         token: token,
         state: state,
       );

  /// Returns a shallow copy of this [JoinResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JoinResult copyWith({
    String? token,
    _ie092xer.JudgeState? state,
  }) {
    return JoinResult(
      token: token ?? this.token,
      state: state ?? this.state.copyWith(),
    );
  }
}
