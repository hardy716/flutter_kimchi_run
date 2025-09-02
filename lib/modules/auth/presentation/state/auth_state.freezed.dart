// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthIdle value)?  idle,TResult Function( AuthSuccess value)?  success,TResult Function( AuthFailed value)?  failed,TResult Function( AuthLoading value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthIdle() when idle != null:
return idle(_that);case AuthSuccess() when success != null:
return success(_that);case AuthFailed() when failed != null:
return failed(_that);case AuthLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthIdle value)  idle,required TResult Function( AuthSuccess value)  success,required TResult Function( AuthFailed value)  failed,required TResult Function( AuthLoading value)  loading,}){
final _that = this;
switch (_that) {
case AuthIdle():
return idle(_that);case AuthSuccess():
return success(_that);case AuthFailed():
return failed(_that);case AuthLoading():
return loading(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthIdle value)?  idle,TResult? Function( AuthSuccess value)?  success,TResult? Function( AuthFailed value)?  failed,TResult? Function( AuthLoading value)?  loading,}){
final _that = this;
switch (_that) {
case AuthIdle() when idle != null:
return idle(_that);case AuthSuccess() when success != null:
return success(_that);case AuthFailed() when failed != null:
return failed(_that);case AuthLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( User? user)?  success,TResult Function( Exception? exception)?  failed,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthIdle() when idle != null:
return idle();case AuthSuccess() when success != null:
return success(_that.user);case AuthFailed() when failed != null:
return failed(_that.exception);case AuthLoading() when loading != null:
return loading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( User? user)  success,required TResult Function( Exception? exception)  failed,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case AuthIdle():
return idle();case AuthSuccess():
return success(_that.user);case AuthFailed():
return failed(_that.exception);case AuthLoading():
return loading();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( User? user)?  success,TResult? Function( Exception? exception)?  failed,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case AuthIdle() when idle != null:
return idle();case AuthSuccess() when success != null:
return success(_that.user);case AuthFailed() when failed != null:
return failed(_that.exception);case AuthLoading() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class AuthIdle implements AuthState {
  const AuthIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.idle()';
}


}




/// @nodoc


class AuthSuccess implements AuthState {
  const AuthSuccess({required this.user});
  

 final  User? user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSuccessCopyWith<AuthSuccess> get copyWith => _$AuthSuccessCopyWithImpl<AuthSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthSuccessCopyWith(AuthSuccess value, $Res Function(AuthSuccess) _then) = _$AuthSuccessCopyWithImpl;
@useResult
$Res call({
 User? user
});




}
/// @nodoc
class _$AuthSuccessCopyWithImpl<$Res>
    implements $AuthSuccessCopyWith<$Res> {
  _$AuthSuccessCopyWithImpl(this._self, this._then);

  final AuthSuccess _self;
  final $Res Function(AuthSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(AuthSuccess(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}


}

/// @nodoc


class AuthFailed implements AuthState {
  const AuthFailed({required this.exception});
  

 final  Exception? exception;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailedCopyWith<AuthFailed> get copyWith => _$AuthFailedCopyWithImpl<AuthFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailed&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'AuthState.failed(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $AuthFailedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthFailedCopyWith(AuthFailed value, $Res Function(AuthFailed) _then) = _$AuthFailedCopyWithImpl;
@useResult
$Res call({
 Exception? exception
});




}
/// @nodoc
class _$AuthFailedCopyWithImpl<$Res>
    implements $AuthFailedCopyWith<$Res> {
  _$AuthFailedCopyWithImpl(this._self, this._then);

  final AuthFailed _self;
  final $Res Function(AuthFailed) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = freezed,}) {
  return _then(AuthFailed(
exception: freezed == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}


}

/// @nodoc


class AuthLoading implements AuthState {
  const AuthLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




// dart format on
