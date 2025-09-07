// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankingUserEntity {

 String get uid; String get nickname; int get highScore; int get playCount; Timestamp get updatedAt;
/// Create a copy of RankingUserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingUserEntityCopyWith<RankingUserEntity> get copyWith => _$RankingUserEntityCopyWithImpl<RankingUserEntity>(this as RankingUserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingUserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.playCount, playCount) || other.playCount == playCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,uid,nickname,highScore,playCount,updatedAt);

@override
String toString() {
  return 'RankingUserEntity(uid: $uid, nickname: $nickname, highScore: $highScore, playCount: $playCount, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RankingUserEntityCopyWith<$Res>  {
  factory $RankingUserEntityCopyWith(RankingUserEntity value, $Res Function(RankingUserEntity) _then) = _$RankingUserEntityCopyWithImpl;
@useResult
$Res call({
 String uid, String nickname, int highScore, int playCount, Timestamp updatedAt
});




}
/// @nodoc
class _$RankingUserEntityCopyWithImpl<$Res>
    implements $RankingUserEntityCopyWith<$Res> {
  _$RankingUserEntityCopyWithImpl(this._self, this._then);

  final RankingUserEntity _self;
  final $Res Function(RankingUserEntity) _then;

/// Create a copy of RankingUserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? nickname = null,Object? highScore = null,Object? playCount = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,playCount: null == playCount ? _self.playCount : playCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingUserEntity].
extension RankingUserEntityPatterns on RankingUserEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingUserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingUserEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingUserEntity value)  $default,){
final _that = this;
switch (_that) {
case _RankingUserEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingUserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RankingUserEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String nickname,  int highScore,  int playCount,  Timestamp updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingUserEntity() when $default != null:
return $default(_that.uid,_that.nickname,_that.highScore,_that.playCount,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String nickname,  int highScore,  int playCount,  Timestamp updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RankingUserEntity():
return $default(_that.uid,_that.nickname,_that.highScore,_that.playCount,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String nickname,  int highScore,  int playCount,  Timestamp updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RankingUserEntity() when $default != null:
return $default(_that.uid,_that.nickname,_that.highScore,_that.playCount,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RankingUserEntity implements RankingUserEntity {
   _RankingUserEntity({required this.uid, required this.nickname, required this.highScore, required this.playCount, required this.updatedAt});
  

@override final  String uid;
@override final  String nickname;
@override final  int highScore;
@override final  int playCount;
@override final  Timestamp updatedAt;

/// Create a copy of RankingUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingUserEntityCopyWith<_RankingUserEntity> get copyWith => __$RankingUserEntityCopyWithImpl<_RankingUserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingUserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.playCount, playCount) || other.playCount == playCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,uid,nickname,highScore,playCount,updatedAt);

@override
String toString() {
  return 'RankingUserEntity(uid: $uid, nickname: $nickname, highScore: $highScore, playCount: $playCount, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RankingUserEntityCopyWith<$Res> implements $RankingUserEntityCopyWith<$Res> {
  factory _$RankingUserEntityCopyWith(_RankingUserEntity value, $Res Function(_RankingUserEntity) _then) = __$RankingUserEntityCopyWithImpl;
@override @useResult
$Res call({
 String uid, String nickname, int highScore, int playCount, Timestamp updatedAt
});




}
/// @nodoc
class __$RankingUserEntityCopyWithImpl<$Res>
    implements _$RankingUserEntityCopyWith<$Res> {
  __$RankingUserEntityCopyWithImpl(this._self, this._then);

  final _RankingUserEntity _self;
  final $Res Function(_RankingUserEntity) _then;

/// Create a copy of RankingUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? nickname = null,Object? highScore = null,Object? playCount = null,Object? updatedAt = null,}) {
  return _then(_RankingUserEntity(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,playCount: null == playCount ? _self.playCount : playCount // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
