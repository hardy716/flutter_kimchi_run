import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/ranking_user_entity.dart';

part 'ranking_state.freezed.dart';

@freezed
abstract class RankingState with _$RankingState {
  factory RankingState({
    required RankingUserEntity? rankingUser,
    required List<RankingUserEntity> top100RankingUsers,
    required List<RankingUserEntity> friendsRankingUsers,
    required int? ranking,
  }) = _RankingState;
}