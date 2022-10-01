// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiplication_archivement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultiplicationAdopter extends TypeAdapter<_$_Multiplication> {
  @override
  final int typeId = 0;

  @override
  _$_Multiplication read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Multiplication(
      id: fields[0] as int,
      beginnerDone: fields[1] as bool,
      professionalDone: fields[2] as bool,
      practiceChallenges: fields[3] as int,
      beginnerChallenges: fields[4] as int,
      professionalChallenges: fields[5] as int,
      maxPracticeAnswer: fields[6] as int,
      maxBeginnerAnswer: fields[7] as int,
      maxProfessionalAnswer: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Multiplication obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.beginnerDone)
      ..writeByte(2)
      ..write(obj.professionalDone)
      ..writeByte(3)
      ..write(obj.practiceChallenges)
      ..writeByte(4)
      ..write(obj.beginnerChallenges)
      ..writeByte(5)
      ..write(obj.professionalChallenges)
      ..writeByte(6)
      ..write(obj.maxPracticeAnswer)
      ..writeByte(7)
      ..write(obj.maxBeginnerAnswer)
      ..writeByte(8)
      ..write(obj.maxProfessionalAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiplicationAdopter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
