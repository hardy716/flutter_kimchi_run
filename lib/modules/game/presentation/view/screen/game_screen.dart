import 'package:flutter/material.dart';
import 'package:flutter_kimchi_run/gen/assets.gen.dart';
import 'package:flutter_kimchi_run/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../router/route_paths.dart';
import '../../../../../core/theme/app/app_texts.dart';
import '../../../../ranking/presentation/view_model/ranking_view_model.dart';
import '../widgets/game_webview.dart';
import '../game_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameStateProvider);

    return Scaffold(
      appBar: (false)
          ? AppBar(
              backgroundColor: ColorName.skyBlue100,
              surfaceTintColor: Colors.transparent,
              actions: [
                TextButton(
                  onPressed: () async {
                    context.go(AppRoute.ranking.path);
                    await ref.ranking.fetchRankingUser();
                    await ref.ranking.fetchTop100RankingUser();
                    await ref.ranking.fetchCurrentRanking();
                  },
                  child: Row(
                    children: [Text('RANKING', style: AppTexts.b3.copyWith(decoration: TextDecoration.underline))],
                  ),
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          GameWebView(key: gameWebViewKey),
          if (false) ... [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExpandedAlign(child: Assets.images.titleKimchiRun227x331x.image()),
                ExpandedAlign(child: ActionTextButton(text: 'START', onTap: () {})),
              ],
            ),
          ],
          if (state.errorMessage != null) _buildErrorOverlay(),
        ],
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
}
