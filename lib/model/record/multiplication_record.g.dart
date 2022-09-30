// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiplication_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultiplicationRecordAdopter extends TypeAdapter<_$_MultiplicationRecord> {
  @override
  final int typeId = 1;

  @override
  _$_MultiplicationRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_MultiplicationRecord(
      date: fields[0] as String?,
      totalChallenges: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_MultiplicationRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.totalChallenges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiplicationRecordAdopter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
