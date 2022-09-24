import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'multiplication_archivement.freezed.dart';
part 'multiplication_archivement.g.dart';

@freezed
abstract class Multiplication with _$Multiplication {
  @HiveType(typeId: 0, adapterName: 'MultiplicationAdopter')
  const factory Multiplication({
    @HiveField(0) @Default(0) int id,
    //コースを修了したか
    @HiveField(1) @Default(false) bool beginnerDone,
    @HiveField(2) @Default(false) bool professionalDone,
    //各コースに何回挑戦したか
    @HiveField(3) @Default(0) int practiceChallenges,
    @HiveField(4) @Default(0) int beginnerChallenges,
    @HiveField(5) @Default(0) int professionalChallenges,
    //各コースの最大正解数
    @HiveField(6) @Default(0) int maxPracticeAnswer,
    @HiveField(7) @Default(0) int maxBeginnerAnswer,
    @HiveField(8) @Default(0) int maxProfessionalAnswer,
    //プロダクション以降にパラメータを追加する際はそれ以前のユーザがNullになることを考慮しなければいけない
    //例えば int hogeNum　を追記した時 openHiveBoxはエラーを吐く
    //なので int? hogeNum とするべき
  }) = _Multiplication;
}
