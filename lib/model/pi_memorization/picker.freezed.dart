// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'picker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PickerState {
  int get digitsFrom => throw _privateConstructorUsedError;
  int get digitsTo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PickerStateCopyWith<PickerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickerStateCopyWith<$Res> {
  factory $PickerStateCopyWith(
          PickerState value, $Res Function(PickerState) then) =
      _$PickerStateCopyWithImpl<$Res>;
  $Res call({int digitsFrom, int digitsTo});
}

/// @nodoc
class _$PickerStateCopyWithImpl<$Res> implements $PickerStateCopyWith<$Res> {
  _$PickerStateCopyWithImpl(this._value, this._then);

  final PickerState _value;
  // ignore: unused_field
  final $Res Function(PickerState) _then;

  @override
  $Res call({
    Object? digitsFrom = freezed,
    Object? digitsTo = freezed,
  }) {
    return _then(_value.copyWith(
      digitsFrom: digitsFrom == freezed
          ? _value.digitsFrom
          : digitsFrom // ignore: cast_nullable_to_non_nullable
              as int,
      digitsTo: digitsTo == freezed
          ? _value.digitsTo
          : digitsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PickerStateCopyWith<$Res>
    implements $PickerStateCopyWith<$Res> {
  factory _$$_PickerStateCopyWith(
          _$_PickerState value, $Res Function(_$_PickerState) then) =
      __$$_PickerStateCopyWithImpl<$Res>;
  @override
  $Res call({int digitsFrom, int digitsTo});
}

/// @nodoc
class __$$_PickerStateCopyWithImpl<$Res> extends _$PickerStateCopyWithImpl<$Res>
    implements _$$_PickerStateCopyWith<$Res> {
  __$$_PickerStateCopyWithImpl(
      _$_PickerState _value, $Res Function(_$_PickerState) _then)
      : super(_value, (v) => _then(v as _$_PickerState));

  @override
  _$_PickerState get _value => super._value as _$_PickerState;

  @override
  $Res call({
    Object? digitsFrom = freezed,
    Object? digitsTo = freezed,
  }) {
    return _then(_$_PickerState(
      digitsFrom: digitsFrom == freezed
          ? _value.digitsFrom
          : digitsFrom // ignore: cast_nullable_to_non_nullable
              as int,
      digitsTo: digitsTo == freezed
          ? _value.digitsTo
          : digitsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PickerState implements _PickerState {
  const _$_PickerState({this.digitsFrom = 1, this.digitsTo = 50});

  @override
  @JsonKey()
  final int digitsFrom;
  @override
  @JsonKey()
  final int digitsTo;

  @override
  String toString() {
    return 'PickerState(digitsFrom: $digitsFrom, digitsTo: $digitsTo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PickerState &&
            const DeepCollectionEquality()
                .equals(other.digitsFrom, digitsFrom) &&
            const DeepCollectionEquality().equals(other.digitsTo, digitsTo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(digitsFrom),
      const DeepCollectionEquality().hash(digitsTo));

  @JsonKey(ignore: true)
  @override
  _$$_PickerStateCopyWith<_$_PickerState> get copyWith =>
      __$$_PickerStateCopyWithImpl<_$_PickerState>(this, _$identity);
}

abstract class _PickerState implements PickerState {
  const factory _PickerState({final int digitsFrom, final int digitsTo}) =
      _$_PickerState;

  @override
  int get digitsFrom;
  @override
  int get digitsTo;
  @override
  @JsonKey(ignore: true)
  _$$_PickerStateCopyWith<_$_PickerState> get copyWith =>
      throw _privateConstructorUsedError;
}
