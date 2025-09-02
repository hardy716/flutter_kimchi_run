import '../../../../core/base/result.dart';

abstract class NicknameRepository {
  Future<Result<void, Exception>> checkDuplicateNickname({required String nickname});

  Future<Result<void, Exception>> updateNickname({required String nickname});
}