import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'multiplication_store.freezed.dart';

@freezed
abstract class Multiplication with _$Multiplication {
  @HiveType(typeId: 0, adapterName: 'MultiplicationAdopter')
  const factory Multiplication({
    @HiveField(0) @Default(0) int id,
    @HiveField(1) @Default(false) bool beginnerDone,
    @HiveField(2) @Default(false) bool professionalDone,
    @HiveField(3) @Default(0) int tryTimes,
  }) = _Multiplication;
}
