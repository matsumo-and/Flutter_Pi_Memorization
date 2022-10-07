// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pi_best_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PiBestRecord {
//yyyymmddのString型でDateTimeを管理
  @HiveField(0)
  String? get date => throw _privateConstructorUsedError;
  @HiveField(1)
  int? get bestRecord => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PiBestRecordCopyWith<PiBestRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PiBestRecordCopyWith<$Res> {
  factory $PiBestRecordCopyWith(
          PiBestRecord value, $Res Function(PiBestRecord) then) =
      _$PiBestRecordCopyWithImpl<$Res>;
  $Res call({@HiveField(0) String? date, @HiveField(1) int? bestRecord});
}

/// @nodoc
class _$PiBestRecordCopyWithImpl<$Res> implements $PiBestRecordCopyWith<$Res> {
  _$PiBestRecordCopyWithImpl(this._value, this._then);

  final PiBestRecord _value;
  // ignore: unused_field
  final $Res Function(PiBestRecord) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? bestRecord = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      bestRecord: bestRecord == freezed
          ? _value.bestRecord
          : bestRecord // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_PiBestRecordCopyWith<$Res>
    implements $PiBestRecordCopyWith<$Res> {
  factory _$$_PiBestRecordCopyWith(
          _$_PiBestRecord value, $Res Function(_$_PiBestRecord) then) =
      __$$_PiBestRecordCopyWithImpl<$Res>;
  @override
  $Res call({@HiveField(0) String? date, @HiveField(1) int? bestRecord});
}

/// @nodoc
class __$$_PiBestRecordCopyWithImpl<$Res>
    extends _$PiBestRecordCopyWithImpl<$Res>
    implements _$$_PiBestRecordCopyWith<$Res> {
  __$$_PiBestRecordCopyWithImpl(
      _$_PiBestRecord _value, $Res Function(_$_PiBestRecord) _then)
      : super(_value, (v) => _then(v as _$_PiBestRecord));

  @override
  _$_PiBestRecord get _value => super._value as _$_PiBestRecord;

  @override
  $Res call({
    Object? date = freezed,
    Object? bestRecord = freezed,
  }) {
    return _then(_$_PiBestRecord(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      bestRecord: bestRecord == freezed
          ? _value.bestRecord
          : bestRecord // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 3, adapterName: 'PiBestRecordAdopter')
class _$_PiBestRecord implements _PiBestRecord {
  const _$_PiBestRecord(
      {@HiveField(0) this.date, @HiveField(1) this.bestRecord});

//yyyymmddのString型でDateTimeを管理
  @override
  @HiveField(0)
  final String? date;
  @override
  @HiveField(1)
  final int? bestRecord;

  @override
  String toString() {
    return 'PiBestRecord(date: $date, bestRecord: $bestRecord)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PiBestRecord &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.bestRecord, bestRecord));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(bestRecord));

  @JsonKey(ignore: true)
  @override
  _$$_PiBestRecordCopyWith<_$_PiBestRecord> get copyWith =>
      __$$_PiBestRecordCopyWithImpl<_$_PiBestRecord>(this, _$identity);
}

abstract class _PiBestRecord implements PiBestRecord {
  const factory _PiBestRecord(
      {@HiveField(0) final String? date,
      @HiveField(1) final int? bestRecord}) = _$_PiBestRecord;

  @override //yyyymmddのString型でDateTimeを管理
  @HiveField(0)
  String? get date;
  @override
  @HiveField(1)
  int? get bestRecord;
  @override
  @JsonKey(ignore: true)
  _$$_PiBestRecordCopyWith<_$_PiBestRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
