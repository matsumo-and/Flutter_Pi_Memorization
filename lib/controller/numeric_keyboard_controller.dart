import 'package:flutter_riverpod/flutter_riverpod.dart';

final keyboardProvider =
    StateNotifierProvider<KeyboardController, String>((ref) {
  return KeyboardController('');
});

class KeyboardController extends StateNotifier<String> {
  KeyboardController(String text) : super(text);

  void insert(value) {
    if (state.length <= 3) {
      state = state + value;
    }
  }

  void backSpace() {
    final int position = state.length - 1;
    if (position <= -1) {
      return;
    } else {
      state = state.substring(0, position);
    }
  }

  void clear() {
    state = '';
  }
}
