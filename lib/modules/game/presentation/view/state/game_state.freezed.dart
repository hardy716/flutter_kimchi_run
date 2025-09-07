// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameState {

 GameUI get ui; double get progress; bool get isLoading; bool get isUnityReady; bool get isShowLogin; bool get isShowRanking; String? get errorMessage;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&(identical(other.ui, ui) || other.ui == ui)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUnityReady, isUnityReady) || other.isUnityReady == isUnityReady)&&(identical(other.isShowLogin, isShowLogin) || other.isShowLogin == isShowLogin)&&(identical(other.isShowRanking, isShowRanking) || other.isShowRanking == isShowRanking)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,ui,progress,isLoading,isUnityReady,isShowLogin,isShowRanking,errorMessage);

@override
String toString() {
  return 'GameState(ui: $ui, progress: $progress, isLoading: $isLoading, isUnityReady: $isUnityReady, isShowLogin: $isShowLogin, isShowRanking: $isShowRanking, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 GameUI ui, double progress, bool isLoading, bool isUnityReady, bool isShowLogin, bool isShowRanking, String? errorMessage
});




}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ui = null,Object? progress = null,Object? isLoading = null,Object? isUnityReady = null,Object? isShowLogin = null,Object? isShowRanking = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
ui: null == ui ? _self.ui : ui // ignore: cast_nullable_to_non_nullable
as GameUI,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUnityReady: null == isUnityReady ? _self.isUnityReady : isUnityReady // ignore: cast_nullable_to_non_nullable
as bool,isShowLogin: null == isShowLogin ? _self.isShowLogin : isShowLogin // ignore: cast_nullable_to_non_nullable
as bool,isShowRanking: null == isShowRanking ? _self.isShowRanking : isShowRanking // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GameUI ui,  double progress,  bool isLoading,  bool isUnityReady,  bool isShowLogin,  bool isShowRanking,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.ui,_that.progress,_that.isLoading,_that.isUnityReady,_that.isShowLogin,_that.isShowRanking,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GameUI ui,  double progress,  bool isLoading,  bool isUnityReady,  bool isShowLogin,  bool isShowRanking,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.ui,_that.progress,_that.isLoading,_that.isUnityReady,_that.isShowLogin,_that.isShowRanking,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GameUI ui,  double progress,  bool isLoading,  bool isUnityReady,  bool isShowLogin,  bool isShowRanking,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.ui,_that.progress,_that.isLoading,_that.isUnityReady,_that.isShowLogin,_that.isShowRanking,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GameState implements GameState {
   _GameState({required this.ui, required this.progress, required this.isLoading, required this.isUnityReady, required this.isShowLogin, required this.isShowRanking, this.errorMessage});
  

@override final  GameUI ui;
@override final  double progress;
@override final  bool isLoading;
@override final  bool isUnityReady;
@override final  bool isShowLogin;
@override final  bool isShowRanking;
@override final  String? errorMessage;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&(identical(other.ui, ui) || other.ui == ui)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUnityReady, isUnityReady) || other.isUnityReady == isUnityReady)&&(identical(other.isShowLogin, isShowLogin) || other.isShowLogin == isShowLogin)&&(identical(other.isShowRanking, isShowRanking) || other.isShowRanking == isShowRanking)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,ui,progress,isLoading,isUnityReady,isShowLogin,isShowRanking,errorMessage);

@override
String toString() {
  return 'GameState(ui: $ui, progress: $progress, isLoading: $isLoading, isUnityReady: $isUnityReady, isShowLogin: $isShowLogin, isShowRanking: $isShowRanking, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 GameUI ui, double progress, bool isLoading, bool isUnityReady, bool isShowLogin, bool isShowRanking, String? errorMessage
});




}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ui = null,Object? progress = null,Object? isLoading = null,Object? isUnityReady = null,Object? isShowLogin = null,Object? isShowRanking = null,Object? errorMessage = freezed,}) {
  return _then(_GameState(
ui: null == ui ? _self.ui : ui // ignore: cast_nullable_to_non_nullable
as GameUI,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUnityReady: null == isUnityReady ? _self.isUnityReady : isUnityReady // ignore: cast_nullable_to_non_nullable
as bool,isShowLogin: null == isShowLogin ? _self.isShowLogin : isShowLogin // ignore: cast_nullable_to_non_nullable
as bool,isShowRanking: null == isShowRanking ? _self.isShowRanking : isShowRanking // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
