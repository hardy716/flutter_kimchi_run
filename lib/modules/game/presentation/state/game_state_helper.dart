import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/game_view_model.dart';
import 'game_state.dart';


mixin class GetGameState {
  GameState watchGameState(WidgetRef ref) {
    return ref.watch(gameViewModelProvider);
  }

  GameUI watchGameUI(WidgetRef ref) {
    return ref.watch(gameViewModelProvider.select((value) => value.ui));
  }

  bool isShowLogin(WidgetRef ref) {
    return ref.watch(gameViewModelProvider.select((value) => value.isShowLogin));
  }

  bool isShowRanking(WidgetRef ref) {
    return ref.watch(gameViewModelProvider.select((value) => value.isShowRanking));
  }

  String watchGameErrorMessage(WidgetRef ref) {
    return ref.watch(gameViewModelProvider.select((value) => value.errorMessage ?? ''));
  }
}