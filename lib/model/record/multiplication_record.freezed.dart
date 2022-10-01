// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'multiplication_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MultiplicationRecord {
  @HiveField(0)
  String? get date => throw _privateConstructorUsedError;
  @HiveField(1)
  int get totalChallenges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiplicationRecordCopyWith<MultiplicationRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiplicationRecordCopyWith<$Res> {
  factory $MultiplicationRecordCopyWith(MultiplicationRecord value,
          $Res Function(MultiplicationRecord) then) =
      _$MultiplicationRecordCopyWithImpl<$Res>;
  $Res call({@HiveField(0) String? date, @HiveField(1) int totalChallenges});
}

/// @nodoc
class _$MultiplicationRecordCopyWithImpl<$Res>
    implements $MultiplicationRecordCopyWith<$Res> {
  _$MultiplicationRecordCopyWithImpl(this._value, this._then);

  final MultiplicationRecord _value;
  // ignore: unused_field
  final $Res Function(MultiplicationRecord) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? totalChallenges = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      totalChallenges: totalChallenges == freezed
          ? _value.totalChallenges
          : totalChallenges // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_MultiplicationRecordCopyWith<$Res>
    implements $MultiplicationRecordCopyWith<$Res> {
  factory _$$_MultiplicationRecordCopyWith(_$_MultiplicationRecord value,
          $Res Function(_$_MultiplicationRecord) then) =
      __$$_MultiplicationRecordCopyWithImpl<$Res>;
  @override
  $Res call({@HiveField(0) String? date, @HiveField(1) int totalChallenges});
}

/// @nodoc
class __$$_MultiplicationRecordCopyWithImpl<$Res>
    extends _$MultiplicationRecordCopyWithImpl<$Res>
    implements _$$_MultiplicationRecordCopyWith<$Res> {
  __$$_MultiplicationRecordCopyWithImpl(_$_MultiplicationRecord _value,
      $Res Function(_$_MultiplicationRecord) _then)
      : super(_value, (v) => _then(v as _$_MultiplicationRecord));

  @override
  _$_MultiplicationRecord get _value => super._value as _$_MultiplicationRecord;

  @override
  $Res call({
    Object? date = freezed,
    Object? totalChallenges = freezed,
  }) {
    return _then(_$_MultiplicationRecord(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      totalChallenges: totalChallenges == freezed
          ? _value.totalChallenges
          : totalChallenges // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 1, adapterName: 'MultiplicationRecordAdopter')
class _$_MultiplicationRecord implements _MultiplicationRecord {
  const _$_MultiplicationRecord(
      {@HiveField(0) this.date, @HiveField(1) this.totalChallenges = 0});

  @override
  @HiveField(0)
  final String? date;
  @override
  @JsonKey()
  @HiveField(1)
  final int totalChallenges;

  @override
  String toString() {
    return 'MultiplicationRecord(date: $date, totalChallenges: $totalChallenges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultiplicationRecord &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.totalChallenges, totalChallenges));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(totalChallenges));

  @JsonKey(ignore: true)
  @override
  _$$_MultiplicationRecordCopyWith<_$_MultiplicationRecord> get copyWith =>
      __$$_MultiplicationRecordCopyWithImpl<_$_MultiplicationRecord>(
          this, _$identity);
}

abstract class _MultiplicationRecord implements MultiplicationRecord {
  const factory _MultiplicationRecord(
      {@HiveField(0) final String? date,
      @HiveField(1) final int totalChallenges}) = _$_MultiplicationRecord;

  @override
  @HiveField(0)
  String? get date;
  @override
  @HiveField(1)
  int get totalChallenges;
  @override
  @JsonKey(ignore: true)
  _$$_MultiplicationRecordCopyWith<_$_MultiplicationRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
