// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankingState {

 RankingUserEntity? get rankingUser; List<RankingUserEntity> get top100RankingUsers; List<RankingUserEntity> get friendsRankingUsers; int? get ranking;
/// Create a copy of RankingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingStateCopyWith<RankingState> get copyWith => _$RankingStateCopyWithImpl<RankingState>(this as RankingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingState&&(identical(other.rankingUser, rankingUser) || other.rankingUser == rankingUser)&&const DeepCollectionEquality().equals(other.top100RankingUsers, top100RankingUsers)&&const DeepCollectionEquality().equals(other.friendsRankingUsers, friendsRankingUsers)&&(identical(other.ranking, ranking) || other.ranking == ranking));
}


@override
int get hashCode => Object.hash(runtimeType,rankingUser,const DeepCollectionEquality().hash(top100RankingUsers),const DeepCollectionEquality().hash(friendsRankingUsers),ranking);

@override
String toString() {
  return 'RankingState(rankingUser: $rankingUser, top100RankingUsers: $top100RankingUsers, friendsRankingUsers: $friendsRankingUsers, ranking: $ranking)';
}


}

/// @nodoc
abstract mixin class $RankingStateCopyWith<$Res>  {
  factory $RankingStateCopyWith(RankingState value, $Res Function(RankingState) _then) = _$RankingStateCopyWithImpl;
@useResult
$Res call({
 RankingUserEntity? rankingUser, List<RankingUserEntity> top100RankingUsers, List<RankingUserEntity> friendsRankingUsers, int? ranking
});


$RankingUserEntityCopyWith<$Res>? get rankingUser;

}
/// @nodoc
class _$RankingStateCopyWithImpl<$Res>
    implements $RankingStateCopyWith<$Res> {
  _$RankingStateCopyWithImpl(this._self, this._then);

  final RankingState _self;
  final $Res Function(RankingState) _then;

/// Create a copy of RankingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rankingUser = freezed,Object? top100RankingUsers = null,Object? friendsRankingUsers = null,Object? ranking = freezed,}) {
  return _then(_self.copyWith(
rankingUser: freezed == rankingUser ? _self.rankingUser : rankingUser // ignore: cast_nullable_to_non_nullable
as RankingUserEntity?,top100RankingUsers: null == top100RankingUsers ? _self.top100RankingUsers : top100RankingUsers // ignore: cast_nullable_to_non_nullable
as List<RankingUserEntity>,friendsRankingUsers: null == friendsRankingUsers ? _self.friendsRankingUsers : friendsRankingUsers // ignore: cast_nullable_to_non_nullable
as List<RankingUserEntity>,ranking: freezed == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of RankingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingUserEntityCopyWith<$Res>? get rankingUser {
    if (_self.rankingUser == null) {
    return null;
  }

  return $RankingUserEntityCopyWith<$Res>(_self.rankingUser!, (value) {
    return _then(_self.copyWith(rankingUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [RankingState].
extension RankingStatePatterns on RankingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingState value)  $default,){
final _that = this;
switch (_that) {
case _RankingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingState value)?  $default,){
final _that = this;
switch (_that) {
case _RankingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RankingUserEntity? rankingUser,  List<RankingUserEntity> top100RankingUsers,  List<RankingUserEntity> friendsRankingUsers,  int? ranking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingState() when $default != null:
return $default(_that.rankingUser,_that.top100RankingUsers,_that.friendsRankingUsers,_that.ranking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RankingUserEntity? rankingUser,  List<RankingUserEntity> top100RankingUsers,  List<RankingUserEntity> friendsRankingUsers,  int? ranking)  $default,) {final _that = this;
switch (_that) {
case _RankingState():
return $default(_that.rankingUser,_that.top100RankingUsers,_that.friendsRankingUsers,_that.ranking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RankingUserEntity? rankingUser,  List<RankingUserEntity> top100RankingUsers,  List<RankingUserEntity> friendsRankingUsers,  int? ranking)?  $default,) {final _that = this;
switch (_that) {
case _RankingState() when $default != null:
return $default(_that.rankingUser,_that.top100RankingUsers,_that.friendsRankingUsers,_that.ranking);case _:
  return null;

}
}

}

/// @nodoc


class _RankingState implements RankingState {
   _RankingState({required this.rankingUser, required final  List<RankingUserEntity> top100RankingUsers, required final  List<RankingUserEntity> friendsRankingUsers, required this.ranking}): _top100RankingUsers = top100RankingUsers,_friendsRankingUsers = friendsRankingUsers;
  

@override final  RankingUserEntity? rankingUser;
 final  List<RankingUserEntity> _top100RankingUsers;
@override List<RankingUserEntity> get top100RankingUsers {
  if (_top100RankingUsers is EqualUnmodifiableListView) return _top100RankingUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_top100RankingUsers);
}

 final  List<RankingUserEntity> _friendsRankingUsers;
@override List<RankingUserEntity> get friendsRankingUsers {
  if (_friendsRankingUsers is EqualUnmodifiableListView) return _friendsRankingUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friendsRankingUsers);
}

@override final  int? ranking;

/// Create a copy of RankingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingStateCopyWith<_RankingState> get copyWith => __$RankingStateCopyWithImpl<_RankingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingState&&(identical(other.rankingUser, rankingUser) || other.rankingUser == rankingUser)&&const DeepCollectionEquality().equals(other._top100RankingUsers, _top100RankingUsers)&&const DeepCollectionEquality().equals(other._friendsRankingUsers, _friendsRankingUsers)&&(identical(other.ranking, ranking) || other.ranking == ranking));
}


@override
int get hashCode => Object.hash(runtimeType,rankingUser,const DeepCollectionEquality().hash(_top100RankingUsers),const DeepCollectionEquality().hash(_friendsRankingUsers),ranking);

@override
String toString() {
  return 'RankingState(rankingUser: $rankingUser, top100RankingUsers: $top100RankingUsers, friendsRankingUsers: $friendsRankingUsers, ranking: $ranking)';
}


}

/// @nodoc
abstract mixin class _$RankingStateCopyWith<$Res> implements $RankingStateCopyWith<$Res> {
  factory _$RankingStateCopyWith(_RankingState value, $Res Function(_RankingState) _then) = __$RankingStateCopyWithImpl;
@override @useResult
$Res call({
 RankingUserEntity? rankingUser, List<RankingUserEntity> top100RankingUsers, List<RankingUserEntity> friendsRankingUsers, int? ranking
});


@override $RankingUserEntityCopyWith<$Res>? get rankingUser;

}
/// @nodoc
class __$RankingStateCopyWithImpl<$Res>
    implements _$RankingStateCopyWith<$Res> {
  __$RankingStateCopyWithImpl(this._self, this._then);

  final _RankingState _self;
  final $Res Function(_RankingState) _then;

/// Create a copy of RankingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rankingUser = freezed,Object? top100RankingUsers = null,Object? friendsRankingUsers = null,Object? ranking = freezed,}) {
  return _then(_RankingState(
rankingUser: freezed == rankingUser ? _self.rankingUser : rankingUser // ignore: cast_nullable_to_non_nullable
as RankingUserEntity?,top100RankingUsers: null == top100RankingUsers ? _self._top100RankingUsers : top100RankingUsers // ignore: cast_nullable_to_non_nullable
as List<RankingUserEntity>,friendsRankingUsers: null == friendsRankingUsers ? _self._friendsRankingUsers : friendsRankingUsers // ignore: cast_nullable_to_non_nullable
as List<RankingUserEntity>,ranking: freezed == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of RankingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingUserEntityCopyWith<$Res>? get rankingUser {
    if (_self.rankingUser == null) {
    return null;
  }

  return $RankingUserEntityCopyWith<$Res>(_self.rankingUser!, (value) {
    return _then(_self.copyWith(rankingUser: value));
  });
}
}

// dart format on
