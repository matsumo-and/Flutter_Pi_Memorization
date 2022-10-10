// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pi_archivement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PiArchivementAdopter extends TypeAdapter<_$_PiArchivement> {
  @override
  final int typeId = 2;

  @override
  _$_PiArchivement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_PiArchivement(
      practiceChallenges: fields[0] as int,
      realChallenges: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_PiArchivement obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.practiceChallenges)
      ..writeByte(1)
      ..write(obj.realChallenges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PiArchivementAdopter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
