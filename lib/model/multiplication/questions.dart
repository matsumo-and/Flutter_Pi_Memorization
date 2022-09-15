import 'dart:math';

class MathPair {
  final int multiplier;
  final int multiplicand;

  const MathPair(this.multiplier, this.multiplicand);
}

class Questions {
  final List<int> multiplierList;
  final List<int> multiplicandList;

  const Questions({
    required this.multiplierList,
    required this.multiplicandList,
  });

  static int _random(List<int> list) {
    final Random random = Random();
    final int max = list.length;

    final randomNum = random.nextInt(max);

    return list[randomNum];
  }

  MathPair pair() {
    return MathPair(_random(multiplierList), _random(multiplicandList));
  }
}
