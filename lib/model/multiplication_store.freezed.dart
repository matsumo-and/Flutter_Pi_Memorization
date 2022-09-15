// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'multiplication_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Multiplication {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  bool get beginnerDone => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get professionalDone => throw _privateConstructorUsedError;
  @HiveField(3)
  int get practiceNum => throw _privateConstructorUsedError;
  @HiveField(4)
  int get beginnerNum => throw _privateConstructorUsedError;
  @HiveField(5)
  int get professionalNum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiplicationCopyWith<Multiplication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiplicationCopyWith<$Res> {
  factory $MultiplicationCopyWith(
          Multiplication value, $Res Function(Multiplication) then) =
      _$MultiplicationCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) bool beginnerDone,
      @HiveField(2) bool professionalDone,
      @HiveField(3) int practiceNum,
      @HiveField(4) int beginnerNum,
      @HiveField(5) int professionalNum});
}

/// @nodoc
class _$MultiplicationCopyWithImpl<$Res>
    implements $MultiplicationCopyWith<$Res> {
  _$MultiplicationCopyWithImpl(this._value, this._then);

  final Multiplication _value;
  // ignore: unused_field
  final $Res Function(Multiplication) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? beginnerDone = freezed,
    Object? professionalDone = freezed,
    Object? practiceNum = freezed,
    Object? beginnerNum = freezed,
    Object? professionalNum = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      beginnerDone: beginnerDone == freezed
          ? _value.beginnerDone
          : beginnerDone // ignore: cast_nullable_to_non_nullable
              as bool,
      professionalDone: professionalDone == freezed
          ? _value.professionalDone
          : professionalDone // ignore: cast_nullable_to_non_nullable
              as bool,
      practiceNum: practiceNum == freezed
          ? _value.practiceNum
          : practiceNum // ignore: cast_nullable_to_non_nullable
              as int,
      beginnerNum: beginnerNum == freezed
          ? _value.beginnerNum
          : beginnerNum // ignore: cast_nullable_to_non_nullable
              as int,
      professionalNum: professionalNum == freezed
          ? _value.professionalNum
          : professionalNum // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_MultiplicationCopyWith<$Res>
    implements $MultiplicationCopyWith<$Res> {
  factory _$$_MultiplicationCopyWith(
          _$_Multiplication value, $Res Function(_$_Multiplication) then) =
      __$$_MultiplicationCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) bool beginnerDone,
      @HiveField(2) bool professionalDone,
      @HiveField(3) int practiceNum,
      @HiveField(4) int beginnerNum,
      @HiveField(5) int professionalNum});
}

/// @nodoc
class __$$_MultiplicationCopyWithImpl<$Res>
    extends _$MultiplicationCopyWithImpl<$Res>
    implements _$$_MultiplicationCopyWith<$Res> {
  __$$_MultiplicationCopyWithImpl(
      _$_Multiplication _value, $Res Function(_$_Multiplication) _then)
      : super(_value, (v) => _then(v as _$_Multiplication));

  @override
  _$_Multiplication get _value => super._value as _$_Multiplication;

  @override
  $Res call({
    Object? id = freezed,
    Object? beginnerDone = freezed,
    Object? professionalDone = freezed,
    Object? practiceNum = freezed,
    Object? beginnerNum = freezed,
    Object? professionalNum = freezed,
  }) {
    return _then(_$_Multiplication(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      beginnerDone: beginnerDone == freezed
          ? _value.beginnerDone
          : beginnerDone // ignore: cast_nullable_to_non_nullable
              as bool,
      professionalDone: professionalDone == freezed
          ? _value.professionalDone
          : professionalDone // ignore: cast_nullable_to_non_nullable
              as bool,
      practiceNum: practiceNum == freezed
          ? _value.practiceNum
          : practiceNum // ignore: cast_nullable_to_non_nullable
              as int,
      beginnerNum: beginnerNum == freezed
          ? _value.beginnerNum
          : beginnerNum // ignore: cast_nullable_to_non_nullable
              as int,
      professionalNum: professionalNum == freezed
          ? _value.professionalNum
          : professionalNum // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 0, adapterName: 'MultiplicationAdopter')
class _$_Multiplication implements _Multiplication {
  const _$_Multiplication(
      {@HiveField(0) this.id = 0,
      @HiveField(1) this.beginnerDone = false,
      @HiveField(2) this.professionalDone = false,
      @HiveField(3) this.practiceNum = 0,
      @HiveField(4) this.beginnerNum = 0,
      @HiveField(5) this.professionalNum = 0});

  @override
  @JsonKey()
  @HiveField(0)
  final int id;
  @override
  @JsonKey()
  @HiveField(1)
  final bool beginnerDone;
  @override
  @JsonKey()
  @HiveField(2)
  final bool professionalDone;
  @override
  @JsonKey()
  @HiveField(3)
  final int practiceNum;
  @override
  @JsonKey()
  @HiveField(4)
  final int beginnerNum;
  @override
  @JsonKey()
  @HiveField(5)
  final int professionalNum;

  @override
  String toString() {
    return 'Multiplication(id: $id, beginnerDone: $beginnerDone, professionalDone: $professionalDone, practiceNum: $practiceNum, beginnerNum: $beginnerNum, professionalNum: $professionalNum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Multiplication &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.beginnerDone, beginnerDone) &&
            const DeepCollectionEquality()
                .equals(other.professionalDone, professionalDone) &&
            const DeepCollectionEquality()
                .equals(other.practiceNum, practiceNum) &&
            const DeepCollectionEquality()
                .equals(other.beginnerNum, beginnerNum) &&
            const DeepCollectionEquality()
                .equals(other.professionalNum, professionalNum));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(beginnerDone),
      const DeepCollectionEquality().hash(professionalDone),
      const DeepCollectionEquality().hash(practiceNum),
      const DeepCollectionEquality().hash(beginnerNum),
      const DeepCollectionEquality().hash(professionalNum));

  @JsonKey(ignore: true)
  @override
  _$$_MultiplicationCopyWith<_$_Multiplication> get copyWith =>
      __$$_MultiplicationCopyWithImpl<_$_Multiplication>(this, _$identity);
}

abstract class _Multiplication implements Multiplication {
  const factory _Multiplication(
      {@HiveField(0) final int id,
      @HiveField(1) final bool beginnerDone,
      @HiveField(2) final bool professionalDone,
      @HiveField(3) final int practiceNum,
      @HiveField(4) final int beginnerNum,
      @HiveField(5) final int professionalNum}) = _$_Multiplication;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  bool get beginnerDone;
  @override
  @HiveField(2)
  bool get professionalDone;
  @override
  @HiveField(3)
  int get practiceNum;
  @override
  @HiveField(4)
  int get beginnerNum;
  @override
  @HiveField(5)
  int get professionalNum;
  @override
  @JsonKey(ignore: true)
  _$$_MultiplicationCopyWith<_$_Multiplication> get copyWith =>
      throw _privateConstructorUsedError;
}
