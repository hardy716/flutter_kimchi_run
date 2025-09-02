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

class RankingScreen extends ConsumerStatefulWidget {
  const RankingScreen({super.key});

  @override
  ConsumerState<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends ConsumerState<RankingScreen> {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.h20,
                      children: [_buildLeftPanelContent(), _buildMyRankingSection()],
                    ),
                  ),
                  _buildTopRankingSection(),
                ],
              ),
            ),
          ),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: TextButton(
          onPressed: () => context.go(AppRoute.game.path),
          child: const Text('<- BACK', style: AppTexts.b3),
        ),
      ),
    );
  }

  Widget _buildLeftPanelContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.h20,
      children: [_buildTitleSection(), _buildMyInfoSection()],
    );
  }

  Widget _buildTitleSection() {
    return Center(child: Assets.images.titleKimchiRun227x331x.image());
  }

  Widget _buildMyInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.w10,
      children: [
        Assets.icons.icKimchi90x961x.image(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.h10,
          children: [
            Text('hardy', style: AppTexts.b3),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  'run'.colored(baseStyle: AppTexts.b4, trailingSpaces: 1),
                  '109'.colored(baseStyle: AppTexts.b3),
                  'times'.colored(baseStyle: AppTexts.b4, leadingSpaces: 1),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMyRankingSection() {
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
          Text('${1 ?? DefaultConstants.dashPlaceholder}', style: AppTexts.b3.copyWith(color: ColorName.yellowGold100)),
          Expanded(
            child: Text(
              'hardy',
              textAlign: TextAlign.center,
              style: AppTexts.b3.copyWith(color: ColorName.yellowGold100),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${12345 ?? DefaultConstants.zeroPlaceholder}',
            style: AppTexts.b3.copyWith(color: ColorName.yellowGold100),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRankingSection() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.darkBlue70,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: ColorName.black70),
        ),
        child: ListView.separated(
          itemCount: 30,
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
                      'nickname',
                      textAlign: TextAlign.center,
                      style: AppTexts.b4.copyWith(color: ColorName.white100),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('12345', style: AppTexts.b4.copyWith(color: ColorName.white100)),
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
