import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_user_entity.freezed.dart';

@freezed
abstract class RankingUserEntity with _$RankingUserEntity {
  factory RankingUserEntity({
    required String uid,
    required String nickname,
    required int highScore,
    required int playCount,
    required Timestamp updatedAt,
  }) = _RankingUserEntity;
}
