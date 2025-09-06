import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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

  // Future<void> diagRanking() async {
  //   final app = Firebase.app();
  //   final user = FirebaseAuth.instance.currentUser;
  //   debugPrint('[DIAG] projectId=${app.options.projectId}  appName=${app.name}  user=${user?.displayName}');
  //   debugPrint('[DIAG] uid=${user?.uid}  isAuth=${user != null}');
  //
  //   if (user == null) return;
  //
  //   final ref = FirebaseFirestore.instance.collection('rankings').doc(user.uid);
  //   debugPrint('[DIAG] path=${ref.path}');
  //
  //   final snap = await ref.get(const GetOptions(source: Source.server));
  //   debugPrint('[DIAG] exists=${snap.exists}  fromCache=${snap.metadata.isFromCache}');
  //   debugPrint('[DIAG] raw=${jsonEncode(snap.data())}');
  // }
}
