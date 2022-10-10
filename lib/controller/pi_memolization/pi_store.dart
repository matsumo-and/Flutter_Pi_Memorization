import 'package:flutter_pi_memorization/model/pi_memorization/pi_archivement.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

///globalに宣言し、bottom_tab_bar.dartで初期化される
final piArchivementProvider =
    StateNotifierProvider<PiArchivementStore, PiArchivement>((ref) {
  return PiArchivementStore(const PiArchivement());
});

class PiArchivementStore extends StateNotifier<PiArchivement> {
  PiArchivementStore(PiArchivement archivement) : super(archivement);

  late Box<PiArchivement> box;

  ///ローカルストレージから円周率の挑戦回数を取得する
  Future<void> initialize() async {
    box = await Hive.openBox<PiArchivement>('PiArchivement');

    //以下コマンドでBoxを初期化できる。
    // box.deleteAll(box.keys);
    // box.deleteFromDisk();

    state = box.get('PiArchivement', defaultValue: const PiArchivement())!;
  }

  Future<void> set({int? practiceChallenges, int? realChallenges}) async {
    state = state.copyWith(
        practiceChallenges: practiceChallenges ?? state.practiceChallenges,
        realChallenges: realChallenges ?? state.realChallenges);

    box.delete('PiArchivement');
    box.put('PiArchivement', state);
  }
}
