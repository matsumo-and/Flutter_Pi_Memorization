import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'total_challenges_record.freezed.dart';
part 'total_challenges_record.g.dart';

@freezed
abstract class TotalChallengesRecord with _$TotalChallengesRecord {
  @HiveType(typeId: 1, adapterName: 'TotalChallengesRecordAdopter')
  const factory TotalChallengesRecord({
    //yyyymmddのString型でDateTimeを管理
    @HiveField(0) @required String? date,
    @HiveField(1) @Default(0) int totalChallenges,
  }) = _TotalChallengesRecord;
}
