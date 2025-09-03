import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/extensions/result_extension.dart';
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

class GetFetchRankingUserUseCase {
  final RankingRepository _rankingRepository;

  GetFetchRankingUserUseCase({required RankingRepository rankingRepository}) : _rankingRepository = rankingRepository;

  Future<Result<RankingUserEntity?, Exception>> fetchRankingUser() async {
    return await _rankingRepository.fetchRankingUserById();
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

  Future<Result<void, Exception>> updateRankingUser({
    required String nickname,
    required int playCount,
    required int highScore,
  }) async {
    return _repository.updateRankingUser(nickname: nickname, playCount: playCount, highScore: highScore);
  }
}