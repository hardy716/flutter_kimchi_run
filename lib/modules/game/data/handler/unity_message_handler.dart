import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/default_constants.dart';
import '../../presentation/state/game_state.dart';
import '../../presentation/view_model/game_view_model.dart';
import '../../presentation/view_model/ranking_view_model.dart';
import 'unity_message_type.dart';



class UnityMessageHandler {
  final WidgetRef ref;

  UnityMessageHandler(this.ref);

  void handleMessage(String message) {
    try {
      final data = jsonDecode(message);
      final String typeString = data['type'] ?? '';
      final dynamic payload = data['data'];

      debugPrint('📦 Parsed Unity message - type: $typeString, data: $payload');

      UnityMessageType? type;
      try {
        type = UnityMessageType.fromString(typeString);
      } catch (e) {
        debugPrint('⚠️ Unhandled Unity message type: $typeString');
        return;
      }

      if (type == null) {
        debugPrint('⚠️ Unknown Unity message type: $typeString');
        return;
      }

      switch (type) {
        case UnityMessageType.unityReady:
          _handleUnityReady();
          break;

        case UnityMessageType.gameOver:
          _handleGameOver();
          break;

        // UI State Messages
        case UnityMessageType.uiStateStart:
          _handleUIState(GameUI.START);
          break;

        case UnityMessageType.uiStatePlaying:
          _handleUIState(GameUI.PLAYING);
          break;

        case UnityMessageType.uiStateFinish:
          _handleUIState(GameUI.FINISH);
          break;

        // Game State Messages
        case UnityMessageType.gameRestarting:
          _handleGameStateChange('Restarting');
          break;

        case UnityMessageType.gameStarted:
          _handleGameStateChange('Started');
          break;

        case UnityMessageType.gamePaused:
          _handleGameStateChange('Paused');
          break;

        case UnityMessageType.gameResumed:
          _handleGameStateChange('Resumed');
          break;

        case UnityMessageType.gameReady:
          _handleGameStatus('Ready');
          break;

        case UnityMessageType.gamePlaying:
          _handleGameStatus('Playing');
          break;

        case UnityMessageType.gameFinished:
          _handleGameStatus('Finished');
          break;

        // Score Message
        case UnityMessageType.unityGameScore:
          _handleScore(payload);
          break;
      }
    } catch (e) {
      debugPrint('Unity 메시지 처리 오류: $e');
    }
  }

  void _handleUnityReady() {
    ref.read(gameViewModelProvider.notifier).setUnityReady(true);
    debugPrint('🎮 Unity is ready!');
  }

  void _handleGameOver() {
    debugPrint('🎮 Unity Game Over!');
  }

  void _handleUIState(GameUI uiState) {
    ref.read(gameViewModelProvider.notifier).updateGameUI(uiState);
    debugPrint('🎮 Unity UI State: ${uiState.name}');
  }

  void _handleGameStateChange(String state) {
    debugPrint('🎮 Unity Game: $state');
  }

  void _handleGameStatus(String status) {
    debugPrint('🎮 Unity Game Status: $status');
  }

  void _handleScore(dynamic payload) {
    if (payload != null) {
      try {
        Map<String, dynamic> scoreData;
        if (payload is String) {
          scoreData = jsonDecode(payload);
        } else {
          scoreData = payload as Map<String, dynamic>;
        }
        
        final int newScore = scoreData['newScore'] ?? DefaultConstants.zeroPlaceholder;
        final int highScore = scoreData['highScore'] ?? DefaultConstants.zeroPlaceholder;

        ref.read(rankingViewModelProvider.notifier).updateRankingUer(highScore: highScore);

        debugPrint('🎮 Unity Game Score: newScore=$newScore, highScore=$highScore');
      } catch (e) {
        debugPrint('❌ Error parsing unity_game_score: $e');
      }
    }
  }
}