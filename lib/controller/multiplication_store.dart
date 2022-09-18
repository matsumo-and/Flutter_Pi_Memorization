import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../model/multiplication/multiplication_archivement.dart';

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

    //以下コマンドでBoxを初期化できる。
    //box.deleteAll(box.keys);

    final List<Multiplication> fetchedList = box.values.toList();

    //Boxが空でなければRiverpodに渡す
    if (fetchedList.isNotEmpty) {
      state = fetchedList;
    }
  }

  ///任意のパラメータを受け取ってRiverpodとローカルストレージを更新する。
  Future<void> set(
      {required int id,
      bool? beginnerDone,
      bool? professionalDone,
      int? practiceNum,
      int? beginnerNum,
      int? professionalNum}) async {
    //現在のIDのオブジェクトを取得し任意のパラメータを変更する
    final Multiplication currentStatus = _find(id);
    final Multiplication addedStatus = currentStatus.copyWith(
      id: id,
      beginnerDone: beginnerDone ?? currentStatus.beginnerDone,
      professionalDone: professionalDone ?? currentStatus.professionalDone,
      practiceNum: practiceNum ?? currentStatus.practiceNum,
      beginnerNum: beginnerNum ?? currentStatus.beginnerNum,
      professionalNum: professionalNum ?? currentStatus.professionalNum,
    );

    //Riverpodから引数のIDを持つオブジェクトを削除してから新たなオブジェクトを格納
    final List<Multiplication> newState = state;
    newState.removeWhere((element) => element.id == id);
    newState.add(addedStatus);

    //idをキーとしてboxに格納。もし既にオブジェクトが格納されていれば消してから格納
    await box.delete(id);
    await box.put(id, addedStatus);

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
