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
mixin _$CalculationState {
  int get index => throw _privateConstructorUsedError;
  int get multiplier => throw _privateConstructorUsedError;
  int get multiplicand => throw _privateConstructorUsedError;
  int get userAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get secElapsed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalculationStateCopyWith<CalculationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculationStateCopyWith<$Res> {
  factory $CalculationStateCopyWith(
          CalculationState value, $Res Function(CalculationState) then) =
      _$CalculationStateCopyWithImpl<$Res>;
  $Res call(
      {int index,
      int multiplier,
      int multiplicand,
      int userAnswer,
      bool isCorrect,
      int secElapsed});
}

/// @nodoc
class _$CalculationStateCopyWithImpl<$Res>
    implements $CalculationStateCopyWith<$Res> {
  _$CalculationStateCopyWithImpl(this._value, this._then);

  final CalculationState _value;
  // ignore: unused_field
  final $Res Function(CalculationState) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? multiplier = freezed,
    Object? multiplicand = freezed,
    Object? userAnswer = freezed,
    Object? isCorrect = freezed,
    Object? secElapsed = freezed,
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
      userAnswer: userAnswer == freezed
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: isCorrect == freezed
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      secElapsed: secElapsed == freezed
          ? _value.secElapsed
          : secElapsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_CalculationStateCopyWith<$Res>
    implements $CalculationStateCopyWith<$Res> {
  factory _$$_CalculationStateCopyWith(
          _$_CalculationState value, $Res Function(_$_CalculationState) then) =
      __$$_CalculationStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int index,
      int multiplier,
      int multiplicand,
      int userAnswer,
      bool isCorrect,
      int secElapsed});
}

/// @nodoc
class __$$_CalculationStateCopyWithImpl<$Res>
    extends _$CalculationStateCopyWithImpl<$Res>
    implements _$$_CalculationStateCopyWith<$Res> {
  __$$_CalculationStateCopyWithImpl(
      _$_CalculationState _value, $Res Function(_$_CalculationState) _then)
      : super(_value, (v) => _then(v as _$_CalculationState));

  @override
  _$_CalculationState get _value => super._value as _$_CalculationState;

  @override
  $Res call({
    Object? index = freezed,
    Object? multiplier = freezed,
    Object? multiplicand = freezed,
    Object? userAnswer = freezed,
    Object? isCorrect = freezed,
    Object? secElapsed = freezed,
  }) {
    return _then(_$_CalculationState(
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
      userAnswer: userAnswer == freezed
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: isCorrect == freezed
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      secElapsed: secElapsed == freezed
          ? _value.secElapsed
          : secElapsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CalculationState implements _CalculationState {
  const _$_CalculationState(
      {this.index = 0,
      this.multiplier = 0,
      this.multiplicand = 0,
      this.userAnswer = 0,
      this.isCorrect = false,
      this.secElapsed = 0});

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
  final int userAnswer;
  @override
  @JsonKey()
  final bool isCorrect;
  @override
  @JsonKey()
  final int secElapsed;

  @override
  String toString() {
    return 'CalculationState(index: $index, multiplier: $multiplier, multiplicand: $multiplicand, userAnswer: $userAnswer, isCorrect: $isCorrect, secElapsed: $secElapsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalculationState &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality()
                .equals(other.multiplier, multiplier) &&
            const DeepCollectionEquality()
                .equals(other.multiplicand, multiplicand) &&
            const DeepCollectionEquality()
                .equals(other.userAnswer, userAnswer) &&
            const DeepCollectionEquality().equals(other.isCorrect, isCorrect) &&
            const DeepCollectionEquality()
                .equals(other.secElapsed, secElapsed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(multiplier),
      const DeepCollectionEquality().hash(multiplicand),
      const DeepCollectionEquality().hash(userAnswer),
      const DeepCollectionEquality().hash(isCorrect),
      const DeepCollectionEquality().hash(secElapsed));

  @JsonKey(ignore: true)
  @override
  _$$_CalculationStateCopyWith<_$_CalculationState> get copyWith =>
      __$$_CalculationStateCopyWithImpl<_$_CalculationState>(this, _$identity);
}

abstract class _CalculationState implements CalculationState {
  const factory _CalculationState(
      {final int index,
      final int multiplier,
      final int multiplicand,
      final int userAnswer,
      final bool isCorrect,
      final int secElapsed}) = _$_CalculationState;

  @override
  int get index;
  @override
  int get multiplier;
  @override
  int get multiplicand;
  @override
  int get userAnswer;
  @override
  bool get isCorrect;
  @override
  int get secElapsed;
  @override
  @JsonKey(ignore: true)
  _$$_CalculationStateCopyWith<_$_CalculationState> get copyWith =>
      throw _privateConstructorUsedError;
}
