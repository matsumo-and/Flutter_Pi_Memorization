import 'package:flutter_pi_memorization/model/multiplication_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final multiplicationProvider =
    StateNotifierProvider<MultiplicationStore, List<Multiplication>>((ref) {
  return MultiplicationStore([]);
});

class MultiplicationStore extends StateNotifier<List<Multiplication>> {
  MultiplicationStore(List<Multiplication> list) : super(list);

  late Box box;

  Future<void> initialize() async {
    box = await Hive.openBox('box');

    List<Multiplication> list = box.get('MultiplicationAdopter') ?? [];

    if (list.isNotEmpty) {
      state = list;
    }
  }

  Multiplication find(int id) {
    return state.firstWhere((element) => element.id == id,
        orElse: () => const Multiplication());
  }
}
