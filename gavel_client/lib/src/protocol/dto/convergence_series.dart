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

/// mu over time for one project, sampled at vote numbers.
abstract class ConvergenceSeries
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConvergenceSeries._({
    required this.projectId,
    required this.name,
    required this.voteNumbers,
    required this.mus,
  });

  factory ConvergenceSeries({
    required int projectId,
    required String name,
    required List<int> voteNumbers,
    required List<double> mus,
  }) = _ConvergenceSeriesImpl;

  factory ConvergenceSeries.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConvergenceSeries(
      projectId: jsonSerialization['projectId'] as int,
      name: jsonSerialization['name'] as String,
      voteNumbers: _ivmqq51r.Protocol().deserialize<List<int>>(
        jsonSerialization['voteNumbers'],
      ),
      mus: _ivmqq51r.Protocol().deserialize<List<double>>(
        jsonSerialization['mus'],
      ),
    );
  }

  int projectId;

  String name;

  List<int> voteNumbers;

  List<double> mus;

  /// Returns a shallow copy of this [ConvergenceSeries]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConvergenceSeries copyWith({
    int? projectId,
    String? name,
    List<int>? voteNumbers,
    List<double>? mus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConvergenceSeries',
      'projectId': projectId,
      'name': name,
      'voteNumbers': voteNumbers.toJson(),
      'mus': mus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConvergenceSeries',
      'projectId': projectId,
      'name': name,
      'voteNumbers': voteNumbers.toJson(),
      'mus': mus.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ConvergenceSeriesImpl extends ConvergenceSeries {
  _ConvergenceSeriesImpl({
    required int projectId,
    required String name,
    required List<int> voteNumbers,
    required List<double> mus,
  }) : super._(
         projectId: projectId,
         name: name,
         voteNumbers: voteNumbers,
         mus: mus,
       );

  /// Returns a shallow copy of this [ConvergenceSeries]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConvergenceSeries copyWith({
    int? projectId,
    String? name,
    List<int>? voteNumbers,
    List<double>? mus,
  }) {
    return ConvergenceSeries(
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      voteNumbers: voteNumbers ?? this.voteNumbers.map((e0) => e0).toList(),
      mus: mus ?? this.mus.map((e0) => e0).toList(),
    );
  }
}
