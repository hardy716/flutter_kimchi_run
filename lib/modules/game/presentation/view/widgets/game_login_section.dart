import 'package:flutter/material.dart';
import 'package:flutter_kimchi_run/modules/game/presentation/view/view_model/game_view_model.dart';
import 'package:flutter_kimchi_run/modules/ranking/presentation/view_model/ranking_view_model.dart';
import 'package:flutter_kimchi_run/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app/app_paddings.dart';
import '../../../../../shared/view/widgets/action_text_button.dart';
import '../../../../../shared/view/widgets/styled_text_form_field.dart';
import '../../../../ranking/presentation/state/ranking_state_helper.dart';
import '../../../../auth/presentation/view_model/auth_view_model.dart';

class GameLoginSection extends ConsumerStatefulWidget {
  const GameLoginSection({super.key});

  @override
  ConsumerState<GameLoginSection> createState() => _GameLoginSectionState();
}

class _GameLoginSectionState extends ConsumerState<GameLoginSection> with GetRankingState {
  late final TextEditingController _nicknameTextEditingController;

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
        padding: const EdgeInsets.only(left: 80, right: 80, bottom: 20),
        child: SingleChildScrollView(
          padding: AppPaddings.screenPadding,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                StyledTextFormField(
                  hintText: 'nickname',
                  keyboardType: TextInputType.text,
                  controller: _nicknameTextEditingController,
                  onSubmitted: (value) => ref.auth.signInAnonymously(nickname: value),
                ),
                const Spacer(),
                ActionTextButton(
                  text: 'ENTER',
                  onTap: () {
                    ref.ranking.updateNickname(nickname: _nicknameTextEditingController.text);
                    ref.game.updateLoginShow(false);
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