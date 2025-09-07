import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/default_constants.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../shared/shared.dart';
import '../../../../game/presentation/view/state/ranking_state_helper.dart';
import '../../view_model/auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with GetRankingState {
  late final TextEditingController _nicknameTextEditingController;

  @override
  void initState() {
    super.initState();

      _nicknameTextEditingController = TextEditingController(text: readRankingNickname(ref).orPlaceholder(DefaultConstants.emptyPlaceholder));
  }

  @override
  void dispose() {
    _nicknameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: AppPaddings.screenPadding,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                StyledTextFormField(
                  hintText: 'nickname',
                  keyboardType: TextInputType.text,
                  controller: _nicknameTextEditingController,
                  onSubmitted: (value) => ref.auth.signInAnonymously(nickname: value),
                ),
                const Spacer(),
                ActionTextButton(
                  text: 'ENTER',
                  onTap: () => ref.auth.signInAnonymously(nickname: _nicknameTextEditingController.text),
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
