// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pi_archivement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PiArchivement {
  @HiveField(0)
  int get practiceChallenges => throw _privateConstructorUsedError;
  @HiveField(1)
  int get realChallenges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PiArchivementCopyWith<PiArchivement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PiArchivementCopyWith<$Res> {
  factory $PiArchivementCopyWith(
          PiArchivement value, $Res Function(PiArchivement) then) =
      _$PiArchivementCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int practiceChallenges, @HiveField(1) int realChallenges});
}

/// @nodoc
class _$PiArchivementCopyWithImpl<$Res>
    implements $PiArchivementCopyWith<$Res> {
  _$PiArchivementCopyWithImpl(this._value, this._then);

  final PiArchivement _value;
  // ignore: unused_field
  final $Res Function(PiArchivement) _then;

  @override
  $Res call({
    Object? practiceChallenges = freezed,
    Object? realChallenges = freezed,
  }) {
    return _then(_value.copyWith(
      practiceChallenges: practiceChallenges == freezed
          ? _value.practiceChallenges
          : practiceChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      realChallenges: realChallenges == freezed
          ? _value.realChallenges
          : realChallenges // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PiArchivementCopyWith<$Res>
    implements $PiArchivementCopyWith<$Res> {
  factory _$$_PiArchivementCopyWith(
          _$_PiArchivement value, $Res Function(_$_PiArchivement) then) =
      __$$_PiArchivementCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int practiceChallenges, @HiveField(1) int realChallenges});
}

/// @nodoc
class __$$_PiArchivementCopyWithImpl<$Res>
    extends _$PiArchivementCopyWithImpl<$Res>
    implements _$$_PiArchivementCopyWith<$Res> {
  __$$_PiArchivementCopyWithImpl(
      _$_PiArchivement _value, $Res Function(_$_PiArchivement) _then)
      : super(_value, (v) => _then(v as _$_PiArchivement));

  @override
  _$_PiArchivement get _value => super._value as _$_PiArchivement;

  @override
  $Res call({
    Object? practiceChallenges = freezed,
    Object? realChallenges = freezed,
  }) {
    return _then(_$_PiArchivement(
      practiceChallenges: practiceChallenges == freezed
          ? _value.practiceChallenges
          : practiceChallenges // ignore: cast_nullable_to_non_nullable
              as int,
      realChallenges: realChallenges == freezed
          ? _value.realChallenges
          : realChallenges // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 2, adapterName: 'PiArchivementAdopter')
class _$_PiArchivement implements _PiArchivement {
  const _$_PiArchivement(
      {@HiveField(0) this.practiceChallenges = 0,
      @HiveField(1) this.realChallenges = 0});

  @override
  @JsonKey()
  @HiveField(0)
  final int practiceChallenges;
  @override
  @JsonKey()
  @HiveField(1)
  final int realChallenges;

  @override
  String toString() {
    return 'PiArchivement(practiceChallenges: $practiceChallenges, realChallenges: $realChallenges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PiArchivement &&
            const DeepCollectionEquality()
                .equals(other.practiceChallenges, practiceChallenges) &&
            const DeepCollectionEquality()
                .equals(other.realChallenges, realChallenges));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(practiceChallenges),
      const DeepCollectionEquality().hash(realChallenges));

  @JsonKey(ignore: true)
  @override
  _$$_PiArchivementCopyWith<_$_PiArchivement> get copyWith =>
      __$$_PiArchivementCopyWithImpl<_$_PiArchivement>(this, _$identity);
}

abstract class _PiArchivement implements PiArchivement {
  const factory _PiArchivement(
      {@HiveField(0) final int practiceChallenges,
      @HiveField(1) final int realChallenges}) = _$_PiArchivement;

  @override
  @HiveField(0)
  int get practiceChallenges;
  @override
  @HiveField(1)
  int get realChallenges;
  @override
  @JsonKey(ignore: true)
  _$$_PiArchivementCopyWith<_$_PiArchivement> get copyWith =>
      throw _privateConstructorUsedError;
}
