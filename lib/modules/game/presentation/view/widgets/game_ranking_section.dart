import 'package:flutter/material.dart';
import 'package:flutter_kimchi_run/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/default_constants.dart';
import '../../../../../core/theme/app/app_borders.dart';
import '../../../../../core/theme/app/app_sizes.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../core/theme/app/app_texts.dart';
import '../../../../ranking/domain/entity/ranking_user_entity.dart';
import '../../../../ranking/presentation/state/ranking_state_helper.dart';

class GameRankingSection extends ConsumerWidget with GetRankingState {
  const GameRankingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackgroundScaffold(
      child: Padding(
        padding: const EdgeInsets.only(left: 80, top: 10, right: 80, bottom: 30),
        child: Row(
          spacing: AppSpacing.w20,
          children: [
            Expanded(
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
            _buildTop100RankingSection(top100RankingUsers: watchTop100RankingUsers(ref), ranking: watchRanking(ref)),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Center(child: Assets.images.titleKimchiRun227x331x.image());
  }

  Widget _buildMyInfoSection({required RankingUserEntity? rankingUser}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorName.darkBlue70,
        borderRadius: AppBorderRadius.box,
        border: Border.all(color: ColorName.black70),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.w20,
        children: [
          Assets.icons.icKimchi90x961x.image(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.h10,
            children: [
              Text(
                (rankingUser?.nickname).orPlaceholder(placeHolder: DefaultConstants.dashPlaceholder),
                style: AppTexts.b3.copyWith(color: ColorName.white100),
              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    'run'.colored(baseStyle: AppTexts.b4.copyWith(color: ColorName.white100), trailingSpaces: 1),
                    '${rankingUser?.playCount ?? DefaultConstants.zeroPlaceholder}'.colored(
                      baseStyle: AppTexts.b3.copyWith(color: ColorName.white100),
                    ),
                    'times'.colored(baseStyle: AppTexts.b4.copyWith(color: ColorName.white100), leadingSpaces: 1),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
            ('$ranking').orPlaceholder(placeHolder: DefaultConstants.dashPlaceholder),
            style: AppTexts.b3.copyWith(color: ColorName.yellowGold100),
          ),
          Expanded(
            child: Text(
              (rankingUser?.nickname).orPlaceholder(placeHolder: DefaultConstants.dashPlaceholder),
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

  Widget _buildTop100RankingSection({List<RankingUserEntity> top100RankingUsers = const [], int? ranking}) {
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
            final isMyRanking = index + 1 == ranking;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                spacing: AppSpacing.w10,
                children: [
                  Text(
                    '${index + 1}',
                    style: AppTexts.b4.copyWith(color: isMyRanking ? ColorName.yellowGold100 : ColorName.white100),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      (top100RankingUsers[index].nickname).orPlaceholder(placeHolder: DefaultConstants.dashPlaceholder),
                      textAlign: TextAlign.center,
                      style: AppTexts.b4.copyWith(color: isMyRanking ? ColorName.yellowGold100 : ColorName.white100),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${top100RankingUsers[index].highScore}',
                    style: AppTexts.b4.copyWith(color: isMyRanking ? ColorName.yellowGold100 : ColorName.white100),
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
