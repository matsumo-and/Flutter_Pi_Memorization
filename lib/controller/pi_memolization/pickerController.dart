import 'package:flutter_pi_memorization/model/pi_memorization/picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pickerProvider =
    StateNotifierProvider<PickerController, PickerState>((ref) {
  return PickerController(const PickerState());
});

class PickerController extends StateNotifier<PickerState> {
  PickerController(PickerState state) : super(state);

  void set({int? digitsFrom, int? digitsTo}) {
    state = state.copyWith(
        digitsFrom: digitsFrom ?? state.digitsFrom,
        digitsTo: digitsTo ?? state.digitsTo);
  }
}
