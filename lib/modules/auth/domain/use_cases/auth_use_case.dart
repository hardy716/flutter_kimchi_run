import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/extensions/result_extension.dart';
import '../../../game/data/repositories/ranking_repository_impl.dart';
import '../../../game/domain/repositories/ranking_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/nickname_repository_impl.dart';
import '../repositories/auth_repository.dart';
import '../repositories/nickname_repository.dart';

part 'auth_use_case.g.dart';

@riverpod
GetSignInAnonymouslyUseCase getSignInAnonymouslyUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final nicknameRepository = ref.watch(nicknameRepositoryProvider);

  return GetSignInAnonymouslyUseCase(
    authRepository: authRepository,
    nicknameRepository: nicknameRepository,
  );
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

  GetSignInAnonymouslyUseCase({
    required AuthRepository authRepository,
    required NicknameRepository nicknameRepository,
  }) : _authRepository = authRepository,
       _nicknameRepository = nicknameRepository;

  Future<Result<UserCredential?, Exception>> signInAnonymously({String? nickname}) {
    return _authRepository.signInAnonymously().execute(
      onSuccess: (cred) async {
        final user = cred?.user;
        if (user == null) return Failure(Exception('no user'));

        final isNew = cred?.additionalUserInfo?.isNewUser == true;
        final displayName = user.displayName ?? '';
        final currentNickname = (nickname?.isNotEmpty == true) ? nickname! : displayName;

        if (isNew && currentNickname.isEmpty) {
          return Failure(Exception('nickname required for new user'));
        }

        final shouldChangeName = currentNickname.isNotEmpty && currentNickname != displayName;
        if (shouldChangeName) {
          final checkDuplicateNickname = await _nicknameRepository.checkDuplicateNickname(nickname: currentNickname);
          if (checkDuplicateNickname.isFailure) return Failure(Exception('duplicate nickname'));

          final updateNickname = await _nicknameRepository.updateNickname(nickname: currentNickname);
          if (updateNickname.isFailure) return Failure(Exception('failed to update nickname'));
        }

        final ensured = await _authRepository.registerUser(currentNickname);
        if (ensured.isFailure) return Failure(Exception('failed to ensure user docs'));

        return Success(cred);
      },
      onFailure: (e) => Failure(e),
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
    return _authRepository.signOut(userCredential: null);
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
