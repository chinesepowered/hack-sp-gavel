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

/// What the judge's phone should be showing right now.
enum JudgePhase implements _is.SerializableModel {
  /// Joined, has not started yet.
  ready,

  /// Visiting the very first project (nothing to compare against yet).
  visit,

  /// Visiting a project that will be compared with the previous one.
  compare,

  /// Every available project has been seen by this judge.
  finished,

  /// Judging is not open (event in setup or closed).
  closed,

  /// The organizer paused this judge.
  inactive;

  static JudgePhase fromJson(String name) {
    switch (name) {
      case 'ready':
        return JudgePhase.ready;
      case 'visit':
        return JudgePhase.visit;
      case 'compare':
        return JudgePhase.compare;
      case 'finished':
        return JudgePhase.finished;
      case 'closed':
        return JudgePhase.closed;
      case 'inactive':
        return JudgePhase.inactive;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "JudgePhase"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
