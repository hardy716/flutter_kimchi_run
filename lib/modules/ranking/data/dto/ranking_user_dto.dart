import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/ranking_user_entity.dart';

part 'ranking_user_dto.freezed.dart';

@freezed
abstract class RankingUserDto with _$RankingUserDto {
  const RankingUserDto._();

  factory RankingUserDto({
    required String uid,
    required String nickname,
    required int highScore,
    required int playCount,
    required Timestamp updatedAt,
  }) = _RankingUserDto;

  factory RankingUserDto.fromDoc(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return RankingUserDto(
      uid: doc.id,
      nickname: data['nickname'],
      highScore: data['highScore'],
      playCount: data['playCount'],
      updatedAt: data['updatedAt'],
    );
  }

  RankingUserEntity toEntity() =>
      RankingUserEntity(uid: uid, nickname: nickname, highScore: highScore, playCount: playCount, updatedAt: updatedAt);
}
