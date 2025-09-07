import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/game_state.dart';

part 'game_view_model.g.dart';

extension GameRefExtension on WidgetRef {
  GameViewModel get game => read(gameViewModelProvider.notifier);
}

@Riverpod(keepAlive: true)
class GameViewModel extends _$GameViewModel {
  @override
  GameState build() {
    return GameState(
      ui: GameUI.IDLE,
      progress: 0,
      isLoading: true,
      isUnityReady: false,
      errorMessage: null,
      isShowLogin: false,
      isShowRanking: false,
    );
  }

  void updateGameUI(GameUI ui) {
    state = state.copyWith(ui: ui);
  }

  void updateRankingShow(bool isShowRanking) {
    state = state.copyWith(isShowRanking: isShowRanking);
  }

  void updateLoginShow(bool isShowLogin) {
    state = state.copyWith(isShowLogin: isShowLogin);
  }

  void setProgress(double value) {
    state = state.copyWith(progress: value);
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setUnityReady(bool value) {
    state = state.copyWith(isUnityReady: value);
  }

  void setErrorMessage(String? message) {
    state = state.copyWith(errorMessage: message);
  }

  bool get isLoading => state.isLoading;
  bool get isUnityReady => state.isUnityReady;
}
