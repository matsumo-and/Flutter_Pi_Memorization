import 'package:flutter_pi_memorization/model/record/multiplication_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

//bottom_tab_bar.dartで初期化される
final multiplicationRecodeProvider = StateNotifierProvider<
    MultiplicationRecordState, List<MultiplicationRecord>>((ref) {
  return MultiplicationRecordState([]);
});

class MultiplicationRecordState
    extends StateNotifier<List<MultiplicationRecord>> {
  MultiplicationRecordState(List<MultiplicationRecord> list) : super(list);

  late Box<MultiplicationRecord> box;

  void initialize() async {
    box =
        await Hive.openBox<MultiplicationRecord>('MultiplicationRecordAdopter');
    final List<MultiplicationRecord> fetchedList = box.values.toList();

    //Boxが空でなければRiverpodに渡す
    if (fetchedList.isNotEmpty) {
      state = fetchedList;
    }
    print(state);
  }

  void increment() async {
    //yyyyMMdd形式のStringで今日の日付を取得
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('yyyyMMdd');
    final String formatDate = format.format(now);

    //Stateの中で今日の日付の挑戦回数があれば取得する
    final MultiplicationRecord currentRecord = state.firstWhere(
      (record) => record.date == formatDate,
      orElse: () => MultiplicationRecord(date: formatDate, totalChallenges: 0),
    );

    final MultiplicationRecord incrementRecord = currentRecord.copyWith(
        totalChallenges: currentRecord.totalChallenges + 1);

    //RiverpodにIncrementした挑戦回数を格納
    state.removeWhere((record) => record.date == formatDate);
    state = [...state, incrementRecord];

    //Hiveも同様に
    await box.delete(formatDate);
    await box.put(formatDate, incrementRecord);

    initialize();
  }
}
