import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/base/result.dart';

abstract class AuthRepository {
  Future<Result<UserCredential?, Exception>> signInAnonymously();

  Future<Result<void, Exception>> registerUser(String nickname);

  Future<Result<User, Exception>> getCurrentUser();

  Future<Result<UserCredential?, Exception>> signOut({required UserCredential? userCredential});
}
