import 'package:flutter_pi_memorization/model/pi_memorization/pi_best_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

//bottom_tab_bar.dartで初期化される
final piBestRecordsListProvider =
    StateNotifierProvider<PiBestRecordState, List<PiBestRecord>>((ref) {
  return PiBestRecordState([]);
});

class PiBestRecordState extends StateNotifier<List<PiBestRecord>> {
  PiBestRecordState(List<PiBestRecord> list) : super(list);

  late Box<PiBestRecord> box;

  void initialize() async {
    box = await Hive.openBox<PiBestRecord>('PiBestRecordAdopter');
    final List<PiBestRecord> fetchedList = box.values.toList();

    //Boxが空でなければRiverpodに渡す
    if (fetchedList.isNotEmpty) {
      state = fetchedList;
    }

    state = [PiBestRecord(date: '20221010', bestRecord: 10)];
  }

  void update({required int bestRecord}) async {
    //yyyyMMdd形式のStringで今日の日付を取得
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('yyyyMMdd');
    final String formatDate = format.format(now);

    //Stateの中で今日の日付の挑戦回数があれば取得する
    final PiBestRecord currentRecord = state.firstWhere(
      (record) => record.date == formatDate,
      orElse: () => PiBestRecord(date: formatDate, bestRecord: 0),
    );

    final PiBestRecord incrementRecord =
        currentRecord.copyWith(bestRecord: bestRecord);

    //Riverpodにupdateした最高記録を保持
    state.removeWhere((record) => record.date == formatDate);
    state = [...state, incrementRecord];

    //Hiveも同様に
    await box.delete(formatDate);
    await box.put(formatDate, incrementRecord);
  }
}
