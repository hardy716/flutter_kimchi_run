import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<S, E extends Exception> with _$Result<S, E> {
  const factory Result.success(S value) = Success<S, E>;
  const factory Result.failure(E exception) = Failure<S, E>;
}