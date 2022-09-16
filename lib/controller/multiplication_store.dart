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

    //magic word ↓
    //box.deleteAll(box.keys);

    final List<Multiplication> list = box.values.toList();
    print(list);

    if (list.isNotEmpty) {
      print('state update');
      state = list;
    }
  }

  Future<void> add(
      {required int id,
      bool? beginnerDone,
      bool? professionalDone,
      int? practiceNum,
      int? beginnerNum,
      int? professionalNum}) async {
    final Multiplication currentStatus = _find(id);

    final List<Multiplication> newState = state;

    newState.removeWhere(
      (element) => element.id == id,
    );

    newState.add(currentStatus.copyWith(
      id: id,
      beginnerDone: beginnerDone ?? currentStatus.beginnerDone,
      professionalDone: professionalDone ?? currentStatus.professionalDone,
      practiceNum: practiceNum ?? currentStatus.practiceNum,
      beginnerNum: beginnerNum ?? currentStatus.beginnerNum,
      professionalNum: professionalNum ?? currentStatus.professionalNum,
    ));

    // await box.delete('MultiplicationAdopter');
    await box.delete(id);
    await box.put(
        id,
        currentStatus.copyWith(
          id: id,
          beginnerDone: beginnerDone ?? currentStatus.beginnerDone,
          professionalDone: professionalDone ?? currentStatus.professionalDone,
          practiceNum: practiceNum ?? currentStatus.practiceNum,
          beginnerNum: beginnerNum ?? currentStatus.beginnerNum,
          professionalNum: professionalNum ?? currentStatus.professionalNum,
        ));

    //state=newStateだけだとStateに更新があったと判断してくれないらしい
    state = [];
    state = newState;
  }

  ///unique id をキーとしてどの掛け算の問題か区別する。
  ///この関数経由で取得したオブジェクトに変更が生じてもWatchできない
  Multiplication _find(int id) {
    return state.firstWhere((element) => element.id == id,
        orElse: () => const Multiplication());
  }
}
