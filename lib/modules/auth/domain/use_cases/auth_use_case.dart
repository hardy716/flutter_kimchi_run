import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/extensions/result_extension.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/nickname_repository_impl.dart';
import '../repositories/auth_repository.dart';
import '../repositories/nickname_repository.dart';

part 'auth_use_case.g.dart';

@riverpod
GetSignInAnonymouslyUseCase getSignInAnonymouslyUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final nicknameRepository = ref.watch(nicknameRepositoryProvider);

  return GetSignInAnonymouslyUseCase(authRepository: authRepository, nicknameRepository: nicknameRepository);
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GetCurrentUserUseCase(authRepository: authRepository);
}

@riverpod
GetSignOutUseCase getSignOutUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GetSignOutUseCase(authRepository: authRepository);
}

@riverpod
GetUpdateNicknameUseCase getUpdateNicknameUseCase(Ref ref) {
  final nicknameRepository = ref.watch(nicknameRepositoryProvider);

  return GetUpdateNicknameUseCase(nicknameRepository: nicknameRepository);
}

class GetSignInAnonymouslyUseCase {
  final AuthRepository _authRepository;
  final NicknameRepository _nicknameRepository;

  GetSignInAnonymouslyUseCase({required AuthRepository authRepository, required NicknameRepository nicknameRepository})
    : _authRepository = authRepository,
      _nicknameRepository = nicknameRepository;

  Future<Result<UserCredential?, Exception>> signInAnonymously({String? nickname}) {
    return _authRepository.signInAnonymously().execute(
      onSuccess: (s) async {
        final isNewUser = (s?.additionalUserInfo?.isNewUser == true);
        if (!isNewUser) {
          if (s?.user?.displayName != nickname && nickname != null) {
            final checkDuplicateNickname = await _nicknameRepository.checkDuplicateNickname(nickname: nickname);
            if (checkDuplicateNickname.isFailure) return Failure(Exception());

            final updateNickname = await _nicknameRepository.updateNickname(nickname: nickname);
            if (updateNickname.isFailure) return Failure(Exception());
          }

          return Success(s);
        }

        if (nickname == null || nickname.isEmpty) return Failure(Exception());

        final checkDuplicateNickname = await _nicknameRepository.checkDuplicateNickname(nickname: nickname);
        if (checkDuplicateNickname.isFailure) return Failure(Exception());

        final registerUser = await _authRepository.registerUser(nickname);
        if (registerUser.isFailure) return Failure(Exception());

        return Success(s);
      },
      onFailure: (f) {
        return Failure(f);
      },
    );
  }
}

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Result<User, Exception>> getCurrentUser() {
    return _authRepository.getCurrentUser();
  }
}

class GetSignOutUseCase {
  final AuthRepository _authRepository;

  GetSignOutUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Result<UserCredential?, Exception>> signOut() {
    return _authRepository.signInAnonymously();
  }
}

class GetUpdateNicknameUseCase {
  final NicknameRepository _nicknameRepository;

  GetUpdateNicknameUseCase({required NicknameRepository nicknameRepository}) : _nicknameRepository = nicknameRepository;

  Future<Result<void, Exception>> updateNickname({required String nickname}) async {
    return await _nicknameRepository
        .checkDuplicateNickname(nickname: nickname)
        .execute(
          onSuccess: (s) async => await _nicknameRepository.updateNickname(nickname: nickname),
          onFailure: (f) => Failure(Exception()),
        );
  }
}
