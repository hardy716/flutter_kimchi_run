import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/ranking_user_entity.dart';
import '../view_model/ranking_view_model.dart';
import 'ranking_state.dart';

mixin class GetRankingState {
  RankingState watchRankingState(WidgetRef ref) {
    return ref.watch(rankingViewModelProvider);
  }

  RankingUserEntity? watchRankingUser(WidgetRef ref) {
    return ref.watch(rankingViewModelProvider).rankingUser;
  }

  List<RankingUserEntity> watchTop100RankingUsers(WidgetRef ref) {
    return ref.watch(rankingViewModelProvider).top100RankingUsers;
  }

  int? watchRanking(WidgetRef ref) {
    return ref.watch(rankingViewModelProvider).ranking;
  }

  String? readRankingNickname(WidgetRef ref) {
    return ref.read(rankingViewModelProvider).rankingUser?.nickname;
  }
}