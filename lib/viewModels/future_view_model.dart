class FutureViewModel {
  static Future<FutureViewModel> createFutureViewModel() async {
    await Future.delayed(const Duration(seconds: 5));
    return FutureViewModel();
  }

  int counter = 1;
  add() {
    counter++;
  }

  subtract() {
    counter--;
  }
}
