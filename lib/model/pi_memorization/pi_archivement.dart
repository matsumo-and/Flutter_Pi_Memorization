import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'pi_archivement.freezed.dart';
part 'pi_archivement.g.dart';

@freezed
abstract class PiArchivement with _$PiArchivement {
  @HiveType(typeId: 2, adapterName: 'PiArchivementAdopter')
  const factory PiArchivement({
    @HiveField(0) @Default(0) int practiceChallenges,
    @HiveField(1) @Default(0) int realChallenges,
  }) = _PiArchivement;
}
