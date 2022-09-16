import 'package:flutter_pi_memorization/model/multiplication/multiplication_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

///globalに宣言し、bottom_tab_bar.dartで初期化される
final multiplicationProvider =
    StateNotifierProvider<MultiplicationStore, List<Multiplication>>((ref) {
  return MultiplicationStore([]);
});

class MultiplicationStore extends StateNotifier<List<Multiplication>> {
  MultiplicationStore(List<Multiplication> list) : super(list);

  late Box<Multiplication> box;

  ///ローカルストレージから掛け算の成績を取得し、Riverpodによる状態管理をする
  Future<void> initialize() async {
    box = await Hive.openBox<Multiplication>('MultiplicationAdopter');
    print(box);
    //final rawData = box.values.cast();

    // if (rawData != null) {
    //   print('state update');
    //   state = rawData;
    // }
  }

  Future<void> add(
      {required int id,
      bool? beginnerDone,
      bool? professionalDone,
      int? practiceNum,
      int? beginnerNum,
      int? professionalNum}) async {
    final Multiplication currentStatus = find(id);

    final List<Multiplication> newState = state;

    if (currentStatus.id == 0) {
      newState.add(Multiplication(
        id: id,
        beginnerDone: beginnerDone ?? false,
        professionalDone: professionalDone ?? false,
        practiceNum: practiceNum ?? 0,
        beginnerNum: beginnerNum ?? 0,
        professionalNum: professionalNum ?? 0,
      ));
    } else {
      newState.removeWhere(
        (element) => element.id == id,
      );
      newState.add(currentStatus.copyWith(
        beginnerDone: beginnerDone ?? currentStatus.beginnerDone,
        professionalDone: professionalDone ?? currentStatus.professionalDone,
        practiceNum: practiceNum ?? currentStatus.practiceNum,
        beginnerNum: beginnerNum ?? currentStatus.beginnerNum,
        professionalNum: professionalNum ?? currentStatus.professionalNum,
      ));
    }

    // await box.delete('MultiplicationAdopter');
    // await box.put('MultiplicationAdopter', newState);
    state = [];
    state = newState;
  }

  ///unique id をキーとしてどの掛け算の問題か区別する。
  Multiplication find(int id) {
    return state.firstWhere((element) => element.id == id,
        orElse: () => const Multiplication());
  }
}
