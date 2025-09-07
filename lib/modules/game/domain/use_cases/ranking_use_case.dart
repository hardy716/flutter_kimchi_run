import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/base/result.dart';
import '../../../../core/extensions/result_extension.dart';
import '../../../auth/data/repositories/nickname_repository_impl.dart';
import '../../../auth/domain/repositories/nickname_repository.dart';
import '../../data/repositories/ranking_repository_impl.dart';
import '../repositories/ranking_repository.dart';
import '../entity/ranking_user_entity.dart';

part 'ranking_use_case.g.dart';

@riverpod
GetFetchRankingUserUseCase getFetchRankingUserUseCase(Ref ref) {
  final rankingRepository = ref.watch(rankingRepositoryProvider);

  return GetFetchRankingUserUseCase(rankingRepository: rankingRepository);
}

@riverpod
GetFetchTop100RankingUsersUseCase getFetchTop100RankingUsersUseCase(Ref ref) {
  final repository = ref.watch(rankingRepositoryProvider);

  return GetFetchTop100RankingUsersUseCase(repository: repository);
}

@riverpod
GetFetchCurrentRankingUseCase getFetchCurrentRankingUseCase(Ref ref) {
  final repository = ref.watch(rankingRepositoryProvider);

  return GetFetchCurrentRankingUseCase(repository: repository);
}

@riverpod
GetUpdateRankingUserUseCase getUpdateRankingUserUseCase(Ref ref) {
  final repository = ref.watch(rankingRepositoryProvider);

  return GetUpdateRankingUserUseCase(repository: repository);
}

@riverpod
GetUpdateAllNicknameUseCase getUpdateAllNicknameUseCase(Ref ref) {
  final nicknameRepository = ref.watch(nicknameRepositoryProvider);
  final rankingRepository = ref.watch(rankingRepositoryProvider);

  return GetUpdateAllNicknameUseCase(nicknameRepository: nicknameRepository, rankingRepository: rankingRepository);
}

class GetFetchRankingUserUseCase {
  final RankingRepository _rankingRepository;

  GetFetchRankingUserUseCase({required RankingRepository rankingRepository}) : _rankingRepository = rankingRepository;

  Future<Result<RankingUserEntity?, Exception>> fetchRankingUser() async {
    return await _rankingRepository.fetchRankingUserById().execute(
      onSuccess: (s) => s != null ? Success(s) : Failure(Exception()),
      onFailure: (f) => Failure(f),
    );
  }
}

class GetFetchTop100RankingUsersUseCase {
  final RankingRepository _repository;

  GetFetchTop100RankingUsersUseCase({required RankingRepository repository}) : _repository = repository;

  Future<Result<List<RankingUserEntity>, Exception>> fetchTop100RankingUsers() async {
    return _repository.fetchTop100RankingUsers();
  }
}

class GetFetchCurrentRankingUseCase {
  final RankingRepository _repository;

  GetFetchCurrentRankingUseCase({required RankingRepository repository}) : _repository = repository;

  Future<Result<int, Exception>> fetchCurrentRanking({required int userScore, required Timestamp updatedAt}) async {
    final higherRankingUserCount = await _repository
        .fetchHigherRankingUserCount(userScore: userScore)
        .execute(onSuccess: (s) => s, onFailure: (f) => -1);

    if (higherRankingUserCount < 0) return Failure(Exception());

    final sameEarlierRankingUserCount = await _repository
        .fetchSameEarlierRankingUserCount(userScore: userScore, updatedAt: updatedAt)
        .execute(onSuccess: (s) => s, onFailure: (f) => -1);

    if (sameEarlierRankingUserCount < 0) return Failure(Exception());

    return Success(higherRankingUserCount + sameEarlierRankingUserCount + 1);
  }
}

class GetUpdateRankingUserUseCase {
  final RankingRepository _repository;

  GetUpdateRankingUserUseCase({required RankingRepository repository}) : _repository = repository;

  Future<Result<void, Exception>> updateRankingUser({required RankingUserEntity rankingUser}) async {
    return _repository.updateRankingUser(
      nickname: rankingUser.nickname,
      playCount: rankingUser.playCount,
      highScore: rankingUser.highScore,
    );
  }
}

class GetUpdateAllNicknameUseCase {
  final NicknameRepository _nicknameRepository;
  final RankingRepository _rankingRepository;

  GetUpdateAllNicknameUseCase({
    required NicknameRepository nicknameRepository,
    required RankingRepository rankingRepository,
  }) : _nicknameRepository = nicknameRepository,
       _rankingRepository = rankingRepository;

  Future<Result<String, Exception>> updateAllNickname({String? nickname}) async {
    if (nickname == null || nickname.trim().isEmpty) {
      return Failure(Exception('닉네임이 비어있습니다'));
    }

    final trimmedNickname = nickname.trim();

    try {
      final duplicateResult = await _nicknameRepository.checkDuplicateNickname(nickname: trimmedNickname);
      if (duplicateResult.isFailure) {
        return Failure(Exception('닉네임 중복 확인 실패'));
      }

      final rankingUserResult = await _rankingRepository.fetchRankingUserById();
      RankingUserEntity? rankingUser;
      switch (rankingUserResult) {
        case Success(value: final userData):
          rankingUser = userData;
          break;
        case Failure():
          rankingUser = null;
          break;
      }

      if (rankingUser == null) {
        return Failure(Exception('사용자 랭킹 정보를 찾을 수 없습니다'));
      }

      final batchResult = await _rankingRepository.updateAllNickname(
        nickname: trimmedNickname,
        playCount: rankingUser.playCount,
        highScore: rankingUser.highScore,
      );

      if (batchResult.isFailure) {
        return Failure(Exception('닉네임 배치 업데이트 실패'));
      }

      return Success(trimmedNickname);
    } catch (e) {
      return Failure(Exception('닉네임 업데이트 중 예상치 못한 오류: $e'));
    }
  }
}
