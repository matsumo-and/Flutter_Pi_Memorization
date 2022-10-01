import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'multiplication_record.freezed.dart';
part 'multiplication_record.g.dart';

@freezed
abstract class MultiplicationRecord with _$MultiplicationRecord {
  @HiveType(typeId: 1, adapterName: 'MultiplicationRecordAdopter')
  const factory MultiplicationRecord({
    //yyyymmddのString型でDateTimeを管理
    @HiveField(0) @required String? date,
    @HiveField(1) @Default(0) int totalChallenges,
  }) = _MultiplicationRecord;
}
