import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../domain/repositories/nickname_repository.dart';
import '../data_sources/nickname_data_source.dart';

part 'nickname_repository_impl.g.dart';

@riverpod
NicknameRepositoryImpl nicknameRepository(Ref ref) {
  final source = ref.watch(firebaseNicknameDataSourceProvider);

  return NicknameRepositoryImpl(source: source);
}

class NicknameRepositoryImpl implements NicknameRepository {
  final FirebaseNicknameDataSource _source;

  NicknameRepositoryImpl({required FirebaseNicknameDataSource source}) : _source = source;

  @override
  Future<Result<void, Exception>> checkDuplicateNickname({required String nickname}) async {
    return await _source.checkDuplicateNickname(nickname: nickname);
  }

  @override
  Future<Result<void, Exception>> updateNickname({required String nickname}) async {
    return await _source.updateNickname(nickname: nickname);
  }
}
