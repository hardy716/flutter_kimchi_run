import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/extensions/result_extension.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../state/auth_state.dart';

part 'auth_view_model.g.dart';

extension AuthRefExtension on WidgetRef {
  AuthViewModel get auth => read(authViewModelProvider.notifier);
}

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<AuthState> build() async {
    state = const AsyncLoading();

    try {
      await getCurrentUser();
    } catch (e, t) {
      state = AsyncError(e, t);

      await signOut();
    }

    return state.value ?? const AuthIdle();
  }

  Future<void> signInAnonymously({String? nickname}) async {
    state = const AsyncLoading();

    await ref
        .read(getSignInAnonymouslyUseCaseProvider)
        .signInAnonymously(nickname: nickname)
        .execute(
          onSuccess: (s) => state = AsyncData(AuthSuccess(user: s?.user)),
          onFailure: (f) => state = AsyncData(AuthFailed(exception: f)),
        );
  }

  Future<void> getCurrentUser() async {
    state = const AsyncLoading();

    await ref
        .read(getCurrentUserUseCaseProvider)
        .getCurrentUser()
        .execute(
          onSuccess: (s) async {
            state = AsyncData(AuthSuccess(user: s));
          },
          onFailure: (f) {
            state = AsyncData(AuthFailed(exception: f));
          },
        );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    await ref
        .read(getSignOutUseCaseProvider)
        .signOut()
        .execute(
          onSuccess: (s) => state = const AsyncData(AuthIdle()),
          onFailure: (f) => state = AsyncData(AuthFailed(exception: f)),
        );
  }
}
