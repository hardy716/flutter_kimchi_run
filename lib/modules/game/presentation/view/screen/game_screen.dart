import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../shared/shared.dart';
import '../../../../auth/presentation/state/auth_state_helper.dart';
import '../view_model/ranking_view_model.dart';
import '../view_model/game_view_model.dart';
import '../state/ranking_state_helper.dart';
import '../state/game_state_helper.dart';
import '../state/game_state.dart';
import '../widgets/game_webview.dart';
import '../widgets/game_app_bar.dart';
import '../widgets/game_ranking_section.dart';
import '../widgets/game_login_section.dart';
import '../widgets/game_splash_section.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with WidgetsBindingObserver, GetAuthState, GetRankingState, GetGameState {
  bool _isShowSplash = true;

  @override
  void initState() {
    super.initState();
  }

  void _checkGameUIAndHideSplash(GameUI gameUI) {
    if (gameUI == GameUI.START && _isShowSplash) {
      setState(() {
        _isShowSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = watchGameState(ref);
    final gameUI = watchGameUI(ref);
    final isLoginShow = isShowLogin(ref);
    final isRankingShow = isShowRanking(ref);

    _checkGameUIAndHideSplash(gameUI);

    return Scaffold(
      backgroundColor: ColorName.skyBlue100,
      appBar: GameAppBar(
        isShow: (!_isShowSplash && gameUI != GameUI.PLAYING),
        onLogin: () {
          ref.game.updateLoginShow(!isLoginShow);
          ref.game.updateRankingShow(false);
        },
        onRanking: () async {
          ref.game.updateRankingShow(!isRankingShow);
          ref.game.updateLoginShow(false);

          await ref.ranking.fetchRankingUser();
          await ref.ranking.fetchTop100RankingUser();
          await ref.ranking.fetchCurrentRanking();
        },
      ),
      body: Stack(
        children: [
          // UNITY WebGL VIEW
          Offstage(
            offstage: _isShowSplash || isLoginShow || isRankingShow || !gameState.isUnityReady,
            child: GameWebView(key: gameWebViewKey),
          ),

          // SPLASH SECTION
          if (_isShowSplash || !gameState.isUnityReady) GameSplashSection(
            progress: gameState.progress, 
            isUnityReady: gameState.isUnityReady,
          ),

          // START SECTION
          if (!_isShowSplash && !isLoginShow && !isRankingShow && gameUI == GameUI.START) _buildStartSection(),

          // RANKING SECTION
          if (!_isShowSplash && isRankingShow) const GameRankingSection(),

          // LOGIN SECTION
          if (!_isShowSplash && isLoginShow) const GameLoginSection(),

          // ERROR SECTION
          if (gameState.errorMessage != null) _buildErrorOverlay(),
        ],
      ),
    );
  }

  Widget _buildStartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExpandedAlign(child: Assets.images.titleKimchiRun227x331x.image()),
        ExpandedAlign(
          child: ActionTextButton(text: 'START', onTap: () {}),
        ),
      ],
    );
  }

  Widget _buildErrorOverlay() {
    return Container(
      color: Colors.red.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.h20,
          children: [
            Icon(Icons.error, size: AppSizes.iconSize.height, color: ColorName.red500),
            Text('로딩 실패: ${watchGameErrorMessage(ref)}'),
            ElevatedButton(onPressed: () => ref.game.setErrorMessage(null), child: const Text('다시 시도')),
          ],
        ),
      ),
    );
  }
}
