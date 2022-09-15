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

  late Box box;

  ///ローカルストレージから掛け算の成績を取得し、Riverpodによる状態管理をする
  Future<void> initialize() async {
    box = await Hive.openBox('box');

    List<Multiplication> list = box.get('MultiplicationAdopter') ?? [];

    if (list.isNotEmpty) {
      state = list;
    }
  }

  ///unique id をキーとしてどの掛け算の問題か区別する。
  Multiplication find(int id) {
    return state.firstWhere((element) => element.id == id,
        orElse: () => const Multiplication());
  }
}
