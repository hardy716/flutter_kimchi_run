import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepositoryImpl authRepository(Ref ref) {
  final source = ref.watch(firebaseAuthDataSourceProvider);

  return AuthRepositoryImpl(source: source);
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _source;

  AuthRepositoryImpl({required FirebaseAuthDataSource source}) : _source = source;

  @override
  Future<Result<UserCredential, Exception>> signInAnonymously() async {
    return await _source.signInAnonymously();
  }

  @override
  Future<Result<void, Exception>> registerUser(String nickname) async {
    return await _source.registerUser(nickname);
  }

  @override
  Future<Result<User, Exception>> getCurrentUser() async {
    return await _source.getCurrentUser();
  }

  @override
  Future<Result<UserCredential?, Exception>> signOut({required UserCredential? userCredential}) async {
    return await _source.signOut();
  }
}
