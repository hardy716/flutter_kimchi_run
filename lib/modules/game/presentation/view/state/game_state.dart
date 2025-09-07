import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

enum GameUI {
  IDLE(0),
  START(1),
  PLAYING(2),
  FINISH(3);

  final int value;

  const GameUI(this.value);
}

@freezed
abstract class GameState with _$GameState {
  factory GameState({
    required GameUI ui,
    required double progress,
    required bool isLoading,
    required bool isUnityReady,
    required bool isShowLogin,
    required bool isShowRanking,
    String? errorMessage,
  }) = _GameState;
}