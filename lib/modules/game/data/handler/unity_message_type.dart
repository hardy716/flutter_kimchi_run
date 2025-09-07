enum UnityMessageType {
  unityReady('unity_ready'),
  gameOver('game_over'),
  
  // UI State Messages
  uiStateStart('ui_state_start'),
  uiStatePlaying('ui_state_playing'),
  uiStateFinish('ui_state_finish'),
  
  // Game State Messages
  gameRestarting('game_restarting'),
  gameStarted('game_started'),
  gamePaused('game_paused'),
  gameResumed('game_resumed'),
  gameReady('game_ready'),
  gamePlaying('game_playing'),
  gameFinished('game_finished'),
  
  // Score Message
  unityGameScore('unity_game_score');

  final String value;
  const UnityMessageType(this.value);

  static UnityMessageType? fromString(String value) {
    return UnityMessageType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw ArgumentError('Unknown Unity message type: $value'),
    );
  }
}