import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/base/result.dart';
import '../entity/ranking_user_entity.dart';

abstract class RankingRepository {
  Future<Result<RankingUserEntity?, Exception>> fetchRankingUserById();

  Future<Result<List<RankingUserEntity>, Exception>> fetchTop100RankingUsers();

  Future<Result<int, Exception>> fetchHigherRankingUserCount({required int userScore});

  Future<Result<int, Exception>> fetchSameEarlierRankingUserCount({required int userScore, required Timestamp updatedAt});

  Future<Result<void, Exception>> updateRankingUser({
    required String nickname,
    required int playCount,
    required int highScore,
  });

  Future<Result<void, Exception>> updateAllNickname({
    required String nickname,
    required int playCount,
    required int highScore,
  });
}