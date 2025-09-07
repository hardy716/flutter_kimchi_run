import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../../../../core/extensions/result_extension.dart';
import '../../../../core/constants/debounce_constants.dart';
import '../../../auth/presentation/view_model/auth_view_model.dart';
import '../../domain/use_cases/ranking_use_case.dart';
import '../state/ranking_state.dart';

part 'ranking_view_model.g.dart';

extension RankingRefExtension on WidgetRef {
  RankingViewModel get ranking => read(rankingViewModelProvider.notifier);
}

@Riverpod(keepAlive: true)
class RankingViewModel extends _$RankingViewModel {
  @override
  RankingState build() {
    return RankingState(rankingUser: null, top100RankingUsers: [], friendsRankingUsers: [], ranking: null);
  }

  Future<void> fetchRankingUser() async {
    EasyDebounce.debounce(DebounceTag.ranking.fetchRankingUser.name, const Duration(milliseconds: 500), () async {
      await ref
          .read(getFetchRankingUserUseCaseProvider)
          .fetchRankingUser()
          .execute(
            onSuccess: (s) {
              state = state.copyWith(rankingUser: s);
            },
            onFailure: (f) {
              ref.read(authViewModelProvider.notifier).signInAnonymously();
            },
          );
    });
  }

  Future<void> fetchTop100RankingUser() async {
    await ref
        .read(getFetchTop100RankingUsersUseCaseProvider)
        .fetchTop100RankingUsers()
        .execute(
          onSuccess: (s) => state = state.copyWith(top100RankingUsers: s),
          onFailure: (f) {},
        );
  }

  Future<void> fetchCurrentRanking() async {
    final rankingUser = state.rankingUser;
    if (rankingUser == null) return;

    await ref
        .read(getFetchCurrentRankingUseCaseProvider)
        .fetchCurrentRanking(userScore: rankingUser.highScore, updatedAt: rankingUser.updatedAt)
        .execute(
          onSuccess: (s) => state = state.copyWith(ranking: s),
          onFailure: (f) {},
        );
  }

  void updateRankingUer({int? highScore}) async {
    if (highScore == null) return;

    if (state.rankingUser == null) {
      await fetchRankingUser();
    }

    final rankingUser = state.rankingUser;
    if (rankingUser == null) return;

    final isNewHighScore = highScore > rankingUser.highScore;

    final newRankingUser = rankingUser.copyWith(
      playCount: rankingUser.playCount + 1,
      highScore: isNewHighScore ? highScore : rankingUser.highScore,
    );

    state = state.copyWith(rankingUser: newRankingUser);

    await ref
        .read(getUpdateRankingUserUseCaseProvider)
        .updateRankingUser(rankingUser: newRankingUser)
        .execute(
          onSuccess: (s) {},
          onFailure: (f) {
            state = state.copyWith(rankingUser: rankingUser);
          },
        );
  }

  Future<bool> updateNickname({required String? nickname}) async {
    return await ref
        .read(getUpdateAllNicknameUseCaseProvider)
        .updateAllNickname(nickname: nickname)
        .execute(onSuccess: (s) => true, onFailure: (f) => false);
  }
}
