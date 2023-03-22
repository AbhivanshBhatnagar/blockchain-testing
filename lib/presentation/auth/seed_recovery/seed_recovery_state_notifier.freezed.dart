// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seed_recovery_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeedRecoveryStateNotifierState {
  SeedRecoveryStateNotifierStatus get status =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeedRecoveryStateNotifierStateCopyWith<SeedRecoveryStateNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeedRecoveryStateNotifierStateCopyWith<$Res> {
  factory $SeedRecoveryStateNotifierStateCopyWith(
          SeedRecoveryStateNotifierState value,
          $Res Function(SeedRecoveryStateNotifierState) then) =
      _$SeedRecoveryStateNotifierStateCopyWithImpl<$Res,
          SeedRecoveryStateNotifierState>;
  @useResult
  $Res call({SeedRecoveryStateNotifierStatus status, String? errorMessage});
}

/// @nodoc
class _$SeedRecoveryStateNotifierStateCopyWithImpl<$Res,
        $Val extends SeedRecoveryStateNotifierState>
    implements $SeedRecoveryStateNotifierStateCopyWith<$Res> {
  _$SeedRecoveryStateNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SeedRecoveryStateNotifierStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeedRecoveryStateNotifierStateCopyWith<$Res>
    implements $SeedRecoveryStateNotifierStateCopyWith<$Res> {
  factory _$$_SeedRecoveryStateNotifierStateCopyWith(
          _$_SeedRecoveryStateNotifierState value,
          $Res Function(_$_SeedRecoveryStateNotifierState) then) =
      __$$_SeedRecoveryStateNotifierStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SeedRecoveryStateNotifierStatus status, String? errorMessage});
}

/// @nodoc
class __$$_SeedRecoveryStateNotifierStateCopyWithImpl<$Res>
    extends _$SeedRecoveryStateNotifierStateCopyWithImpl<$Res,
        _$_SeedRecoveryStateNotifierState>
    implements _$$_SeedRecoveryStateNotifierStateCopyWith<$Res> {
  __$$_SeedRecoveryStateNotifierStateCopyWithImpl(
      _$_SeedRecoveryStateNotifierState _value,
      $Res Function(_$_SeedRecoveryStateNotifierState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_SeedRecoveryStateNotifierState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SeedRecoveryStateNotifierStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SeedRecoveryStateNotifierState
    implements _SeedRecoveryStateNotifierState {
  const _$_SeedRecoveryStateNotifierState(
      {this.status = SeedRecoveryStateNotifierStatus.initial,
      this.errorMessage});

  @override
  @JsonKey()
  final SeedRecoveryStateNotifierStatus status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SeedRecoveryStateNotifierState(status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeedRecoveryStateNotifierState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeedRecoveryStateNotifierStateCopyWith<_$_SeedRecoveryStateNotifierState>
      get copyWith => __$$_SeedRecoveryStateNotifierStateCopyWithImpl<
          _$_SeedRecoveryStateNotifierState>(this, _$identity);
}

abstract class _SeedRecoveryStateNotifierState
    implements SeedRecoveryStateNotifierState {
  const factory _SeedRecoveryStateNotifierState(
      {final SeedRecoveryStateNotifierStatus status,
      final String? errorMessage}) = _$_SeedRecoveryStateNotifierState;

  @override
  SeedRecoveryStateNotifierStatus get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_SeedRecoveryStateNotifierStateCopyWith<_$_SeedRecoveryStateNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}
