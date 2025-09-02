import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app/app_texts.dart';
import '../../../../../router/route_paths.dart';
import '../../../../auth/presentation/view_model/auth_view_model.dart';
import '../widgets/game_webview.dart';
import '../game_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final notifier = ref.read(gameStateProvider);
    if (state == AppLifecycleState.paused) {
      notifier.pauseGame();
    } else if (state == AppLifecycleState.resumed) {
      notifier.resumeGame();
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color, behavior: SnackBarBehavior.floating));
  }

  void _showGameOverDialog() {
    final state = ref.read(gameStateProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎮 게임 오버!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('최종 점수: ${state.score}'), Text('레벨: ${state.level}'), Text('플레이 시간: ${state.formatTime()}')],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(gameStateProvider).restartGame();
            },
            child: const Text('다시 하기'),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('확인')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameStateProvider);
    final notifier = ref.watch(gameStateProvider);

    if (state.isUnityReady && state.isPaused && state.playTime > 0) {
      _showGameOverDialog();
    }

    // Listening to state changes from provider to show SnackBars
    ref.listen(gameStateProvider, (previousState, newState) {
      if (newState.isUnityReady && !previousState!.isUnityReady) {
        _showSnackBar('🎮 Unity 게임 준비 완료!', Colors.green);
      }
      if (newState.level > previousState!.level) {
        _showSnackBar('🎉 레벨 ${newState.level} 달성!', Colors.orange);
      }
      if (newState.errorMessage != null && previousState!.errorMessage == null) {
        _showSnackBar('로딩 실패: ${newState.errorMessage}', Colors.red);
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              if (state.isLoading)
                LinearProgressIndicator(
                  value: state.progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              if (state.isUnityReady)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Colors.blue[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat('점수', state.score.toString(), Icons.star),
                      _buildStat('레벨', state.level.toString(), Icons.flag),
                      _buildStat('시간', notifier.formatTime(), Icons.timer),
                    ],
                  ),
                ),
              const Expanded(child: GameWebView()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => ref.auth.signOut(),
                    child: const Text('<- NICKNAME', style: AppTexts.b3),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoute.ranking.path),
                    child: const Text('RANKING ->', style: AppTexts.b3),
                  ),
                ],
              ),
            ),
          ),
          if (state.isLoading) _buildLoadingOverlay(),
          if (state.errorMessage != null) _buildErrorOverlay(),
          if (state.isPaused) _buildPauseOverlay(),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.blue[700]),
        const SizedBox(width: 4),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black87,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text('Unity 게임 로딩 중...', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorOverlay() {
    return Container(
      color: Colors.red.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text('로딩 실패: ${ref.read(gameStateProvider).errorMessage}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(gameStateProvider).setErrorMessage(null),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPauseOverlay() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pause_circle, color: Colors.white, size: 80),
            SizedBox(height: 16),
            Text('게임 일시정지', style: TextStyle(color: Colors.white, fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
