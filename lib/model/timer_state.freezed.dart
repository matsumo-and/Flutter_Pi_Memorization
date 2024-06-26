// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimerState {
  int? get secLimit => throw _privateConstructorUsedError;
  int get secElapsed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerStateCopyWith<TimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateCopyWith<$Res> {
  factory $TimerStateCopyWith(
          TimerState value, $Res Function(TimerState) then) =
      _$TimerStateCopyWithImpl<$Res>;
  $Res call({int? secLimit, int secElapsed});
}

/// @nodoc
class _$TimerStateCopyWithImpl<$Res> implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._value, this._then);

  final TimerState _value;
  // ignore: unused_field
  final $Res Function(TimerState) _then;

  @override
  $Res call({
    Object? secLimit = freezed,
    Object? secElapsed = freezed,
  }) {
    return _then(_value.copyWith(
      secLimit: secLimit == freezed
          ? _value.secLimit
          : secLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      secElapsed: secElapsed == freezed
          ? _value.secElapsed
          : secElapsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_TimerStateCopyWith<$Res>
    implements $TimerStateCopyWith<$Res> {
  factory _$$_TimerStateCopyWith(
          _$_TimerState value, $Res Function(_$_TimerState) then) =
      __$$_TimerStateCopyWithImpl<$Res>;
  @override
  $Res call({int? secLimit, int secElapsed});
}

/// @nodoc
class __$$_TimerStateCopyWithImpl<$Res> extends _$TimerStateCopyWithImpl<$Res>
    implements _$$_TimerStateCopyWith<$Res> {
  __$$_TimerStateCopyWithImpl(
      _$_TimerState _value, $Res Function(_$_TimerState) _then)
      : super(_value, (v) => _then(v as _$_TimerState));

  @override
  _$_TimerState get _value => super._value as _$_TimerState;

  @override
  $Res call({
    Object? secLimit = freezed,
    Object? secElapsed = freezed,
  }) {
    return _then(_$_TimerState(
      secLimit: secLimit == freezed
          ? _value.secLimit
          : secLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      secElapsed: secElapsed == freezed
          ? _value.secElapsed
          : secElapsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TimerState implements _TimerState {
  const _$_TimerState({this.secLimit, this.secElapsed = 0});

  @override
  final int? secLimit;
  @override
  @JsonKey()
  final int secElapsed;

  @override
  String toString() {
    return 'TimerState(secLimit: $secLimit, secElapsed: $secElapsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerState &&
            const DeepCollectionEquality().equals(other.secLimit, secLimit) &&
            const DeepCollectionEquality()
                .equals(other.secElapsed, secElapsed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(secLimit),
      const DeepCollectionEquality().hash(secElapsed));

  @JsonKey(ignore: true)
  @override
  _$$_TimerStateCopyWith<_$_TimerState> get copyWith =>
      __$$_TimerStateCopyWithImpl<_$_TimerState>(this, _$identity);
}

abstract class _TimerState implements TimerState {
  const factory _TimerState({final int? secLimit, final int secElapsed}) =
      _$_TimerState;

  @override
  int? get secLimit;
  @override
  int get secElapsed;
  @override
  @JsonKey(ignore: true)
  _$$_TimerStateCopyWith<_$_TimerState> get copyWith =>
      throw _privateConstructorUsedError;
}
