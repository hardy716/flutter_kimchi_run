import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/auth_view_model.dart';
import 'auth_state.dart';

mixin class GetAuthState {
  AuthState watchAuthState(WidgetRef ref) {
    final state = ref.watch(authViewModelProvider);

    return state.when(
      data: (data) => data,
      loading: () => const AuthLoading(),
      error: (e, t) => AuthFailed(exception: Exception(e.toString())),
    );
  }

  User? readUser(WidgetRef ref) {
    final state = ref.read(authViewModelProvider);

    return state.when(
      data: (data) {
        if (data is AuthSuccess) return data.user;
        return null;
      },
      loading: () => null,
      error: (e, t) => null,
    );
  }
}