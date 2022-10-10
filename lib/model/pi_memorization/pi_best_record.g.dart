// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pi_best_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PiBestRecordAdopter extends TypeAdapter<_$_PiBestRecord> {
  @override
  final int typeId = 3;

  @override
  _$_PiBestRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_PiBestRecord(
      date: fields[0] as String?,
      bestRecord: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_PiBestRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.bestRecord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PiBestRecordAdopter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
