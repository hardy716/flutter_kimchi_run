import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.idle() = AuthIdle;

  const factory AuthState.success({required User? user}) = AuthSuccess;

  const factory AuthState.failed({required Exception? exception}) = AuthFailed;

  const factory AuthState.loading() = AuthLoading;
}
