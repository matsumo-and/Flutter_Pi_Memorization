import 'package:flutter_pi_memorization/model/record/total_challenges_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

//bottom_tab_bar.dartで初期化される
final piRecordProvider =
    StateNotifierProvider<PiRecordState, List<TotalChallengesRecord>>((ref) {
  return PiRecordState([]);
});

class PiRecordState extends StateNotifier<List<TotalChallengesRecord>> {
  PiRecordState(List<TotalChallengesRecord> list) : super(list);

  late Box<TotalChallengesRecord> box;

  void initialize() async {
    box = await Hive.openBox<TotalChallengesRecord>('PiRecordAdopter');
    final List<TotalChallengesRecord> fetchedList = box.values.toList();

    //Boxが空でなければRiverpodに渡す
    if (fetchedList.isNotEmpty) {
      state = fetchedList;
    }
  }

  void increment() async {
    //yyyyMMdd形式のStringで今日の日付を取得
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('yyyyMMdd');
    final String formatDate = format.format(now);

    //Stateの中で今日の日付の挑戦回数があれば取得する
    final TotalChallengesRecord currentRecord = state.firstWhere(
      (record) => record.date == formatDate,
      orElse: () => TotalChallengesRecord(date: formatDate, totalChallenges: 0),
    );

    final TotalChallengesRecord incrementRecord = currentRecord.copyWith(
        totalChallenges: currentRecord.totalChallenges + 1);

    //RiverpodにIncrementした挑戦回数を格納
    state.removeWhere((record) => record.date == formatDate);
    state = [...state, incrementRecord];

    //Hiveも同様に
    await box.delete(formatDate);
    await box.put(formatDate, incrementRecord);
  }
}
