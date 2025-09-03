// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankingUserDto {

 String get uid; String get nickname; int get highScore; int get playCount; Timestamp get updatedAt;
/// Create a copy of RankingUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingUserDtoCopyWith<RankingUserDto> get copyWith => _$RankingUserDtoCopyWithImpl<RankingUserDto>(this as RankingUserDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingUserDto&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.playCount, playCount) || other.playCount == playCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,uid,nickname,highScore,playCount,updatedAt);

@override
String toString() {
  return 'RankingUserDto(uid: $uid, nickname: $nickname, highScore: $highScore, playCount: $playCount, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RankingUserDtoCopyWith<$Res>  {
  factory $RankingUserDtoCopyWith(RankingUserDto value, $Res Function(RankingUserDto) _then) = _$RankingUserDtoCopyWithImpl;
@useResult
$Res call({
 String uid, String nickname, int highScore, int playCount, Timestamp updatedAt
});




}
/// @nodoc
class _$RankingUserDtoCopyWithImpl<$Res>
    implements $RankingUserDtoCopyWith<$Res> {
  _$RankingUserDtoCopyWithImpl(this._self, this._then);

  final RankingUserDto _self;
  final $Res Function(RankingUserDto) _then;

/// Create a copy of RankingUserDto
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


/// Adds pattern-matching-related methods to [RankingUserDto].
extension RankingUserDtoPatterns on RankingUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingUserDto value)  $default,){
final _that = this;
switch (_that) {
case _RankingUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _RankingUserDto() when $default != null:
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
case _RankingUserDto() when $default != null:
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
case _RankingUserDto():
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
case _RankingUserDto() when $default != null:
return $default(_that.uid,_that.nickname,_that.highScore,_that.playCount,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RankingUserDto extends RankingUserDto {
   _RankingUserDto({required this.uid, required this.nickname, required this.highScore, required this.playCount, required this.updatedAt}): super._();
  

@override final  String uid;
@override final  String nickname;
@override final  int highScore;
@override final  int playCount;
@override final  Timestamp updatedAt;

/// Create a copy of RankingUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingUserDtoCopyWith<_RankingUserDto> get copyWith => __$RankingUserDtoCopyWithImpl<_RankingUserDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingUserDto&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.playCount, playCount) || other.playCount == playCount)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,uid,nickname,highScore,playCount,updatedAt);

@override
String toString() {
  return 'RankingUserDto(uid: $uid, nickname: $nickname, highScore: $highScore, playCount: $playCount, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RankingUserDtoCopyWith<$Res> implements $RankingUserDtoCopyWith<$Res> {
  factory _$RankingUserDtoCopyWith(_RankingUserDto value, $Res Function(_RankingUserDto) _then) = __$RankingUserDtoCopyWithImpl;
@override @useResult
$Res call({
 String uid, String nickname, int highScore, int playCount, Timestamp updatedAt
});




}
/// @nodoc
class __$RankingUserDtoCopyWithImpl<$Res>
    implements _$RankingUserDtoCopyWith<$Res> {
  __$RankingUserDtoCopyWithImpl(this._self, this._then);

  final _RankingUserDto _self;
  final $Res Function(_RankingUserDto) _then;

/// Create a copy of RankingUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? nickname = null,Object? highScore = null,Object? playCount = null,Object? updatedAt = null,}) {
  return _then(_RankingUserDto(
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
