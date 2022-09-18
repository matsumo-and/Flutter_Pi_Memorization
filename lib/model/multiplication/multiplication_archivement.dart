import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'multiplication_archivement.freezed.dart';
part 'multiplication_archivement.g.dart';

@freezed
abstract class Multiplication with _$Multiplication {
  @HiveType(typeId: 0, adapterName: 'MultiplicationAdopter')
  const factory Multiplication({
    @HiveField(0) @Default(0) int id,
    @HiveField(1) @Default(false) bool beginnerDone,
    @HiveField(2) @Default(false) bool professionalDone,
    @HiveField(3) @Default(0) int practiceNum,
    @HiveField(4) @Default(0) int beginnerNum,
    @HiveField(5) @Default(0) int professionalNum,
  }) = _Multiplication;
}
