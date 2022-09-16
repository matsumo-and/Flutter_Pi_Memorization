// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'calculation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MultiplicationState {
  int get index => throw _privateConstructorUsedError;
  int get multiplier => throw _privateConstructorUsedError;
  int get multiplicand => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiplicationStateCopyWith<MultiplicationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiplicationStateCopyWith<$Res> {
  factory $MultiplicationStateCopyWith(
          MultiplicationState value, $Res Function(MultiplicationState) then) =
      _$MultiplicationStateCopyWithImpl<$Res>;
  $Res call({int index, int multiplier, int multiplicand, Duration duration});
}

/// @nodoc
class _$MultiplicationStateCopyWithImpl<$Res>
    implements $MultiplicationStateCopyWith<$Res> {
  _$MultiplicationStateCopyWithImpl(this._value, this._then);

  final MultiplicationState _value;
  // ignore: unused_field
  final $Res Function(MultiplicationState) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? multiplier = freezed,
    Object? multiplicand = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      multiplier: multiplier == freezed
          ? _value.multiplier
          : multiplier // ignore: cast_nullable_to_non_nullable
              as int,
      multiplicand: multiplicand == freezed
          ? _value.multiplicand
          : multiplicand // ignore: cast_nullable_to_non_nullable
              as int,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$$_MultiplicationStateCopyWith<$Res>
    implements $MultiplicationStateCopyWith<$Res> {
  factory _$$_MultiplicationStateCopyWith(_$_MultiplicationState value,
          $Res Function(_$_MultiplicationState) then) =
      __$$_MultiplicationStateCopyWithImpl<$Res>;
  @override
  $Res call({int index, int multiplier, int multiplicand, Duration duration});
}

/// @nodoc
class __$$_MultiplicationStateCopyWithImpl<$Res>
    extends _$MultiplicationStateCopyWithImpl<$Res>
    implements _$$_MultiplicationStateCopyWith<$Res> {
  __$$_MultiplicationStateCopyWithImpl(_$_MultiplicationState _value,
      $Res Function(_$_MultiplicationState) _then)
      : super(_value, (v) => _then(v as _$_MultiplicationState));

  @override
  _$_MultiplicationState get _value => super._value as _$_MultiplicationState;

  @override
  $Res call({
    Object? index = freezed,
    Object? multiplier = freezed,
    Object? multiplicand = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_MultiplicationState(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      multiplier: multiplier == freezed
          ? _value.multiplier
          : multiplier // ignore: cast_nullable_to_non_nullable
              as int,
      multiplicand: multiplicand == freezed
          ? _value.multiplicand
          : multiplicand // ignore: cast_nullable_to_non_nullable
              as int,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_MultiplicationState implements _MultiplicationState {
  const _$_MultiplicationState(
      {this.index = 0,
      this.multiplier = 0,
      this.multiplicand = 0,
      this.duration = const Duration(seconds: 0)});

  @override
  @JsonKey()
  final int index;
  @override
  @JsonKey()
  final int multiplier;
  @override
  @JsonKey()
  final int multiplicand;
  @override
  @JsonKey()
  final Duration duration;

  @override
  String toString() {
    return 'MultiplicationState(index: $index, multiplier: $multiplier, multiplicand: $multiplicand, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultiplicationState &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality()
                .equals(other.multiplier, multiplier) &&
            const DeepCollectionEquality()
                .equals(other.multiplicand, multiplicand) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(multiplier),
      const DeepCollectionEquality().hash(multiplicand),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$$_MultiplicationStateCopyWith<_$_MultiplicationState> get copyWith =>
      __$$_MultiplicationStateCopyWithImpl<_$_MultiplicationState>(
          this, _$identity);
}

abstract class _MultiplicationState implements MultiplicationState {
  const factory _MultiplicationState(
      {final int index,
      final int multiplier,
      final int multiplicand,
      final Duration duration}) = _$_MultiplicationState;

  @override
  int get index;
  @override
  int get multiplier;
  @override
  int get multiplicand;
  @override
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$_MultiplicationStateCopyWith<_$_MultiplicationState> get copyWith =>
      throw _privateConstructorUsedError;
}
