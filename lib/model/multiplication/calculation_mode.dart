enum CalculationMode {
  practice,
  beginner,
  professional,
}

extension CalculationExtention on CalculationMode {
  int? get limit {
    switch (this) {
      case CalculationMode.practice:
        return null;
      case CalculationMode.beginner:
        return 60;
      case CalculationMode.professional:
        return 20;
    }
  }
}
