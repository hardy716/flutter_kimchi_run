import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/route_paths.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../shared/shared.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _nicknameTextEditingController;

  @override
  void initState() {
    super.initState();
    _nicknameTextEditingController = TextEditingController();
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
                  onSubmitted: (value) => context.go(AppRoute.game.path),
                ),
                const Spacer(),
                ActionTextButton(text: 'ENTER', onTap: ()  => context.go(AppRoute.game.path)),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
