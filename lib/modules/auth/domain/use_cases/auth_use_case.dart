import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kimchi_run/modules/ranking/data/repositories/ranking_repository_impl.dart';
import 'package:flutter_kimchi_run/modules/ranking/domain/repositories/ranking_repository.dart';
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
  final rankingRepository = ref.watch(rankingRepositoryProvider);

  return GetSignInAnonymouslyUseCase(
    authRepository: authRepository,
    nicknameRepository: nicknameRepository,
    rankingRepository: rankingRepository,
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
  final RankingRepository _rankingRepository;

  GetSignInAnonymouslyUseCase({
    required AuthRepository authRepository,
    required NicknameRepository nicknameRepository,
    required RankingRepository rankingRepository,
  }) : _authRepository = authRepository,
       _nicknameRepository = nicknameRepository,
       _rankingRepository = rankingRepository;

  Future<Result<UserCredential?, Exception>> signInAnonymously({String? nickname}) {
    return _authRepository.signInAnonymously().execute(
      onSuccess: (cred) async {
        final user = cred?.user;
        if (user == null) return Failure(Exception('no user'));

        final isNew = cred?.additionalUserInfo?.isNewUser == true;
        final currentName = user.displayName ?? '';
        // 신규이면 닉네임 필수, 기존이면 전달 안되면 현재 이름 유지
        final desired = (nickname?.isNotEmpty == true) ? nickname! : currentName;

        if (isNew && desired.isEmpty) {
          return Failure(Exception('nickname required for new user'));
        }

        // 닉네임이 바뀌는 경우에만 선 점검/갱신
        final shouldChangeName = desired.isNotEmpty && desired != currentName;
        if (shouldChangeName) {
          // 1) 중복 체크 (또는 updateNickname 내부에서 create()로 원자 보장)
          final dup = await _nicknameRepository.checkDuplicateNickname(nickname: desired);
          if (dup.isFailure) return Failure(Exception('duplicate nickname'));

          // 2) 닉네임 예약/업데이트 (nicknames/{name} + FirebaseAuth displayName)
          final upd = await _nicknameRepository.updateNickname(nickname: desired);
          if (upd.isFailure) return Failure(Exception('failed to update nickname'));
        }

        // 3) 유저/랭킹 문서 보장 (항상 1회만 호출)
        final ensured = await _authRepository.registerUser(desired);
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
