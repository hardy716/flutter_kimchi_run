import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<S, E extends Exception> with _$Result<S, E> {
  const factory Result.success(S value) = Success<S, E>;
  const factory Result.failure(E exception) = Failure<S, E>;
}

extension FutureResultWhenExtension<S, E extends Exception> on Future<Result<S, E>> {
  Future<T> execute<T>({
    required FutureOr<T> Function(S success) onSuccess,
    required FutureOr<T> Function(E error) onFailure,
  }) async {
    final result = await this;

    return result.when(success: onSuccess, failure: onFailure);
  }
}