import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user_dto.freezed.dart';

@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  factory UserDto({required String uid, required String nickname}) = _UserDto;

  factory UserDto.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserDto(uid: doc.id, nickname: data['nickname']);
  }

  UserEntity toEntity() => UserEntity(uid: uid, nickname: nickname);
}
