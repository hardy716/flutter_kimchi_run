import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../base/result.dart';

extension ResultCheckExtension<S, E extends Exception> on Result<S, E> {
  bool get isSuccess => when(success: (_) => true, failure: (_) => false);
  bool get isFailure => !isSuccess;
}

extension FutureToResultExtension on Future {
  Future<Result<R, Exception>> toResult<R>() async {
    try {
      final result = await this;
      return Result.success(result);
    } on FirebaseException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
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