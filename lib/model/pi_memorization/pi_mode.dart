enum PiMode {
  excersize,
  act,
}

extension PiModeExtention on PiMode {
  String get appBarTitle {
    switch (this) {
      case PiMode.excersize:
        return '練習モード';
      case PiMode.act:
        return '本番モード';
    }
  }
}
