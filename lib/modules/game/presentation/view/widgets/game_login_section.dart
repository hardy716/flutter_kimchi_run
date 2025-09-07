import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/shared.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../auth/presentation/view_model/auth_view_model.dart';
import '../state/ranking_state_helper.dart';
import '../view_model/ranking_view_model.dart';
import '../view_model/game_view_model.dart';

class GameLoginSection extends ConsumerStatefulWidget {
  const GameLoginSection({super.key});

  @override
  ConsumerState<GameLoginSection> createState() => _GameLoginSectionState();
}

class _GameLoginSectionState extends ConsumerState<GameLoginSection> with GetRankingState {
  late final TextEditingController _nicknameTextEditingController;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    _nicknameTextEditingController = TextEditingController(text: readRankingNickname(ref) ?? '');
  }

  @override
  void dispose() {
    _nicknameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Padding(
        padding: AppPaddings.gameLoginSectionOuterPadding,
        child: SingleChildScrollView(
          padding: AppPaddings.screenPadding,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                StyledTextFormField(
                  hintText: 'nickname',
                  keyboardType: TextInputType.text,
                  controller: _nicknameTextEditingController,
                  onSubmitted: (value) => ref.auth.signInAnonymously(nickname: value),
                  isError: isError,
                ),
                const Spacer(),
                ActionTextButton(
                  text: 'ENTER',
                  onTap: () async {
                    final updateNickname = await ref.ranking.updateNickname(nickname: _nicknameTextEditingController.text);
                    if (updateNickname) ref.game.updateLoginShow(false);

                    setState(() {
                      isError = !updateNickname;
                    });
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}