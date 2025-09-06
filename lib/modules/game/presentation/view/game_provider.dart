
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameState extends ChangeNotifier {
  double _progress = 0;
  bool _isLoading = true;
  bool _isUnityReady = false;
  String? _errorMessage;
  int _score = 0;
  int _level = 1;
  bool _isPaused = false;
  bool _isGameStarted = false;
  int _playTime = 0;
  Timer? _playTimeTimer;

  double get progress => _progress;
  bool get isLoading => _isLoading;
  bool get isUnityReady => _isUnityReady;
  String? get errorMessage => _errorMessage;
  int get score => _score;
  int get level => _level;
  bool get isPaused => _isPaused;
  bool get isGameStarted => _isGameStarted;
  int get playTime => _playTime;

  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUnityReady(bool value) {
    _isUnityReady = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void updateScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void updateLevel(int newLevel) {
    _level = newLevel;
    notifyListeners();
  }

  void startGame() {
    _isGameStarted = true;
    _isPaused = false;
    startPlayTimeTimer();
    notifyListeners();
  }

  void pauseGame() {
    _isPaused = true;
    _playTimeTimer?.cancel();
    notifyListeners();
  }

  void resumeGame() {
    _isPaused = false;
    startPlayTimeTimer();
    notifyListeners();
  }

  void restartGame() {
    _score = 0;
    _level = 1;
    _playTime = 0;
    _isPaused = false;
    _isGameStarted = true;
    startPlayTimeTimer();
    notifyListeners();
  }

  void startPlayTimeTimer() {
    if (_playTimeTimer != null) return;
    _playTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _isUnityReady) {
        _playTime++;
        notifyListeners();
      }
    });
  }

  String formatTime() {
    final mins = _playTime ~/ 60;
    final secs = _playTime % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _playTimeTimer?.cancel();
    super.dispose();
  }
}

final gameStateProvider = ChangeNotifierProvider<GameState>((ref) {
  final gameState = GameState();
  return gameState;
});