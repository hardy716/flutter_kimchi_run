import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/extensions/result_extension.dart';
import '../../domain/entity/ranking_user_entity.dart';
import '../../domain/repositories/ranking_repository.dart';
import '../data_sources/ranking_data_source.dart';

part 'ranking_repository_impl.g.dart';

@riverpod
RankingRepositoryImpl rankingRepository(Ref ref) {
  final source = ref.watch(firebaseRankingDataSourceProvider);

  return RankingRepositoryImpl(source: source);
}

class RankingRepositoryImpl implements RankingRepository {
  final FirebaseRankingDataSource _source;

  RankingRepositoryImpl({required FirebaseRankingDataSource source}) : _source = source;

  @override
  Future<Result<RankingUserEntity?, Exception>> fetchRankingUserById() async {
    return await _source.fetchRankingUserById().execute(
      onSuccess: (s) => Success(s?.toEntity()),
      onFailure: (f) => Failure(f),
    );
  }

  @override
  Future<Result<List<RankingUserEntity>, Exception>> fetchTop100RankingUsers() async {
    return await _source.fetchTop100RankingUsers().execute(
      onSuccess: (s) => Success(s.map((e) => e.toEntity()).toList()),
      onFailure: (f) => Failure(f),
    );
  }

  @override
  Future<Result<int, Exception>> fetchHigherRankingUserCount({required int userScore}) async {
    return await _source.fetchHigherRankingUserCount(userScore: userScore);
  }

  @override
  Future<Result<int, Exception>> fetchSameEarlierRankingUserCount({
    required int userScore,
    required Timestamp updatedAt,
  }) async {
    return await _source.fetchSameEarlierRankingUserCount(userScore: userScore, updatedAt: updatedAt);
  }

  @override
  Future<Result<void, Exception>> updateRankingUser({
    required String nickname,
    required int playCount,
    required int highScore,
  }) async {
    return await _source.updateRankingUser(nickname: nickname, playCount: playCount, highScore: highScore);
  }
}
