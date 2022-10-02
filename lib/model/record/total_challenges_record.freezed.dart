// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'total_challenges_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TotalChallengesRecord {
//yyyymmddのString型でDateTimeを管理
  @HiveField(0)
  String? get date => throw _privateConstructorUsedError;
  @HiveField(1)
  int get totalChallenges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TotalChallengesRecordCopyWith<TotalChallengesRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalChallengesRecordCopyWith<$Res> {
  factory $TotalChallengesRecordCopyWith(TotalChallengesRecord value,
          $Res Function(TotalChallengesRecord) then) =
      _$TotalChallengesRecordCopyWithImpl<$Res>;
  $Res call({@HiveField(0) String? date, @HiveField(1) int totalChallenges});
}

/// @nodoc
class _$TotalChallengesRecordCopyWithImpl<$Res>
    implements $TotalChallengesRecordCopyWith<$Res> {
  _$TotalChallengesRecordCopyWithImpl(this._value, this._then);

  final TotalChallengesRecord _value;
  // ignore: unused_field
  final $Res Function(TotalChallengesRecord) _then;

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
abstract class _$$_TotalChallengesRecordCopyWith<$Res>
    implements $TotalChallengesRecordCopyWith<$Res> {
  factory _$$_TotalChallengesRecordCopyWith(_$_TotalChallengesRecord value,
          $Res Function(_$_TotalChallengesRecord) then) =
      __$$_TotalChallengesRecordCopyWithImpl<$Res>;
  @override
  $Res call({@HiveField(0) String? date, @HiveField(1) int totalChallenges});
}

/// @nodoc
class __$$_TotalChallengesRecordCopyWithImpl<$Res>
    extends _$TotalChallengesRecordCopyWithImpl<$Res>
    implements _$$_TotalChallengesRecordCopyWith<$Res> {
  __$$_TotalChallengesRecordCopyWithImpl(_$_TotalChallengesRecord _value,
      $Res Function(_$_TotalChallengesRecord) _then)
      : super(_value, (v) => _then(v as _$_TotalChallengesRecord));

  @override
  _$_TotalChallengesRecord get _value =>
      super._value as _$_TotalChallengesRecord;

  @override
  $Res call({
    Object? date = freezed,
    Object? totalChallenges = freezed,
  }) {
    return _then(_$_TotalChallengesRecord(
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

@HiveType(typeId: 1, adapterName: 'TotalChallengesRecordAdopter')
class _$_TotalChallengesRecord implements _TotalChallengesRecord {
  const _$_TotalChallengesRecord(
      {@HiveField(0) this.date, @HiveField(1) this.totalChallenges = 0});

//yyyymmddのString型でDateTimeを管理
  @override
  @HiveField(0)
  final String? date;
  @override
  @JsonKey()
  @HiveField(1)
  final int totalChallenges;

  @override
  String toString() {
    return 'TotalChallengesRecord(date: $date, totalChallenges: $totalChallenges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TotalChallengesRecord &&
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
  _$$_TotalChallengesRecordCopyWith<_$_TotalChallengesRecord> get copyWith =>
      __$$_TotalChallengesRecordCopyWithImpl<_$_TotalChallengesRecord>(
          this, _$identity);
}

abstract class _TotalChallengesRecord implements TotalChallengesRecord {
  const factory _TotalChallengesRecord(
      {@HiveField(0) final String? date,
      @HiveField(1) final int totalChallenges}) = _$_TotalChallengesRecord;

  @override //yyyymmddのString型でDateTimeを管理
  @HiveField(0)
  String? get date;
  @override
  @HiveField(1)
  int get totalChallenges;
  @override
  @JsonKey(ignore: true)
  _$$_TotalChallengesRecordCopyWith<_$_TotalChallengesRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
