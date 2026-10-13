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

abstract class JudgeSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  JudgeSummary._({
    required this.id,
    required this.name,
    required this.alpha,
    required this.beta,
    required this.reliability,
    required this.agreement,
    required this.votesCast,
    required this.skips,
    required this.active,
    required this.isSimulated,
    this.currentProjectName,
    this.currentLocation,
    this.lastActiveAt,
  });

  factory JudgeSummary({
    required int id,
    required String name,
    required double alpha,
    required double beta,
    required double reliability,
    required double agreement,
    required int votesCast,
    required int skips,
    required bool active,
    required bool isSimulated,
    String? currentProjectName,
    String? currentLocation,
    DateTime? lastActiveAt,
  }) = _JudgeSummaryImpl;

  factory JudgeSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return JudgeSummary(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      alpha: (jsonSerialization['alpha'] as num).toDouble(),
      beta: (jsonSerialization['beta'] as num).toDouble(),
      reliability: (jsonSerialization['reliability'] as num).toDouble(),
      agreement: (jsonSerialization['agreement'] as num).toDouble(),
      votesCast: jsonSerialization['votesCast'] as int,
      skips: jsonSerialization['skips'] as int,
      active: _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      isSimulated: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isSimulated'],
      ),
      currentProjectName: jsonSerialization['currentProjectName'] as String?,
      currentLocation: jsonSerialization['currentLocation'] as String?,
      lastActiveAt: jsonSerialization['lastActiveAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActiveAt'],
            ),
    );
  }

  int id;

  String name;

  double alpha;

  double beta;

  /// alpha / (alpha + beta): how often this judge agrees with the consensus.
  double reliability;

  /// Fraction of this judge's votes that agree with the current consensus.
  double agreement;

  int votesCast;

  int skips;

  bool active;

  bool isSimulated;

  String? currentProjectName;

  String? currentLocation;

  DateTime? lastActiveAt;

  /// Returns a shallow copy of this [JudgeSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JudgeSummary copyWith({
    int? id,
    String? name,
    double? alpha,
    double? beta,
    double? reliability,
    double? agreement,
    int? votesCast,
    int? skips,
    bool? active,
    bool? isSimulated,
    String? currentProjectName,
    String? currentLocation,
    DateTime? lastActiveAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JudgeSummary',
      'id': id,
      'name': name,
      'alpha': alpha,
      'beta': beta,
      'reliability': reliability,
      'agreement': agreement,
      'votesCast': votesCast,
      'skips': skips,
      'active': active,
      'isSimulated': isSimulated,
      if (currentProjectName != null) 'currentProjectName': currentProjectName,
      if (currentLocation != null) 'currentLocation': currentLocation,
      if (lastActiveAt != null) 'lastActiveAt': lastActiveAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JudgeSummary',
      'id': id,
      'name': name,
      'alpha': alpha,
      'beta': beta,
      'reliability': reliability,
      'agreement': agreement,
      'votesCast': votesCast,
      'skips': skips,
      'active': active,
      'isSimulated': isSimulated,
      if (currentProjectName != null) 'currentProjectName': currentProjectName,
      if (currentLocation != null) 'currentLocation': currentLocation,
      if (lastActiveAt != null) 'lastActiveAt': lastActiveAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JudgeSummaryImpl extends JudgeSummary {
  _JudgeSummaryImpl({
    required int id,
    required String name,
    required double alpha,
    required double beta,
    required double reliability,
    required double agreement,
    required int votesCast,
    required int skips,
    required bool active,
    required bool isSimulated,
    String? currentProjectName,
    String? currentLocation,
    DateTime? lastActiveAt,
  }) : super._(
         id: id,
         name: name,
         alpha: alpha,
         beta: beta,
         reliability: reliability,
         agreement: agreement,
         votesCast: votesCast,
         skips: skips,
         active: active,
         isSimulated: isSimulated,
         currentProjectName: currentProjectName,
         currentLocation: currentLocation,
         lastActiveAt: lastActiveAt,
       );

  /// Returns a shallow copy of this [JudgeSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JudgeSummary copyWith({
    int? id,
    String? name,
    double? alpha,
    double? beta,
    double? reliability,
    double? agreement,
    int? votesCast,
    int? skips,
    bool? active,
    bool? isSimulated,
    Object? currentProjectName = _Undefined,
    Object? currentLocation = _Undefined,
    Object? lastActiveAt = _Undefined,
  }) {
    return JudgeSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      alpha: alpha ?? this.alpha,
      beta: beta ?? this.beta,
      reliability: reliability ?? this.reliability,
      agreement: agreement ?? this.agreement,
      votesCast: votesCast ?? this.votesCast,
      skips: skips ?? this.skips,
      active: active ?? this.active,
      isSimulated: isSimulated ?? this.isSimulated,
      currentProjectName: currentProjectName is String?
          ? currentProjectName
          : this.currentProjectName,
      currentLocation: currentLocation is String?
          ? currentLocation
          : this.currentLocation,
      lastActiveAt: lastActiveAt is DateTime?
          ? lastActiveAt
          : this.lastActiveAt,
    );
  }
}
