import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'pi_best_record.freezed.dart';
part 'pi_best_record.g.dart';

@freezed
abstract class PiBestRecord with _$PiBestRecord {
  @HiveType(typeId: 3, adapterName: 'PiBestRecordAdopter')
  const factory PiBestRecord({
    //yyyymmddのString型でDateTimeを管理
    @HiveField(0) @required String? date,
    @HiveField(1) @required int? bestRecord,
  }) = _PiBestRecord;
}
