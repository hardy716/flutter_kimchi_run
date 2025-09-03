import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/constants/default_constants.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../router/route_paths.dart';
import '../../../../../shared/shared.dart';
import '../../../domain/entity/ranking_user_entity.dart';
import '../../state/ranking_state_helper.dart';

class RankingScreen extends ConsumerStatefulWidget {
  const RankingScreen({super.key});

  @override
  ConsumerState<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends ConsumerState<RankingScreen> with GetRankingState {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 20),
              child: Row(
                spacing: AppSpacing.w20,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleSection(),
                          _buildMyInfoSection(rankingUser: watchRankingUser(ref)),
                          _buildMyRankingSection(rankingUser: watchRankingUser(ref), ranking: watchRanking(ref)),
                        ],
                      ),
                    ),
                  ),
                  _buildTop100RankingSection(top100RankingUsers: watchTop100RankingUsers(ref)),
                ],
              ),
            ),
          ),
          _buildBackButton(onPressed: () => context.go(AppRoute.game.path)),
        ],
      ),
    );
  }

  Widget _buildBackButton({required VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: TextButton(
          onPressed: onPressed,
          child: const Text('<- BACK', style: AppTexts.b3),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Center(child: Assets.images.titleKimchiRun227x331x.image());
  }

  Widget _buildMyInfoSection({required RankingUserEntity? rankingUser}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.w10,
      children: [
        Assets.icons.icKimchi90x961x.image(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.h10,
          children: [
            Text(rankingUser?.nickname ?? DefaultConstants.dashPlaceholder, style: AppTexts.b3),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  'run'.colored(baseStyle: AppTexts.b4, trailingSpaces: 1),
                  '${rankingUser?.playCount ?? DefaultConstants.zeroPlaceholder}'.colored(baseStyle: AppTexts.b3),
                  'times'.colored(baseStyle: AppTexts.b4, leadingSpaces: 1),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMyRankingSection({required int? ranking, required RankingUserEntity? rankingUser}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: ColorName.darkBlue70,
        borderRadius: AppBorderRadius.box,
        border: Border.all(color: ColorName.black70),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            '${ranking ?? DefaultConstants.dashPlaceholder}',
            style: AppTexts.b3.copyWith(color: ColorName.yellowGold100),
          ),
          Expanded(
            child: Text(
              rankingUser?.nickname ?? DefaultConstants.dashPlaceholder,
              textAlign: TextAlign.center,
              style: AppTexts.b3.copyWith(color: ColorName.yellowGold100),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${rankingUser?.highScore ?? DefaultConstants.zeroPlaceholder}',
            style: AppTexts.b3.copyWith(color: ColorName.yellowGold100),
          ),
        ],
      ),
    );
  }

  Widget _buildTop100RankingSection({List<RankingUserEntity> top100RankingUsers = const []}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.darkBlue70,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: ColorName.black70),
        ),
        child: ListView.separated(
          itemCount: top100RankingUsers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                spacing: AppSpacing.w10,
                children: [
                  Text('${index + 1}', style: AppTexts.b4.copyWith(color: ColorName.white100)),
                  Expanded(
                    flex: 2,
                    child: Text(
                      top100RankingUsers[index].nickname,
                      textAlign: TextAlign.center,
                      style: AppTexts.b4.copyWith(color: ColorName.white100),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${top100RankingUsers[index].highScore}',
                    style: AppTexts.b4.copyWith(color: ColorName.white100),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(color: Colors.white24, height: 0.5, thickness: 0.5),
        ),
      ),
    );
  }
}
