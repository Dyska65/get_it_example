class RedViewModel {
  RedViewModel() {
    print("Create RedViewModel");
  }
  int counter = 1;
  add() {
    counter++;
    print("Add RedViewModel " + counter.toString());
  }

  subtract() {
    counter--;
    print("Subtract RedViewModel " + counter.toString());
  }
}

class YellowViewModel {
  YellowViewModel() {
    print("Create YellowViewModel");
  }
  int counter = 1;
  add() {
    counter++;
    print("Add YellowViewModel " + counter.toString());
  }

  subtract() {
    counter--;
    print("Subtract YellowViewModel " + counter.toString());
  }
}

class GreenViewModel {
  GreenViewModel() {
    print("Create GreenViewModel");
  }
  int counter = 1;
  add() {
    counter++;
    print("Add GreenViewModel " + counter.toString());
  }

  subtract() {
    counter--;
    print("Subtract GreenViewModel " + counter.toString());
  }
}

class FutureViewModel {
  static Future<FutureViewModel> createFutureViewModel() async {
    await Future.delayed(const Duration(seconds: 3));
    print("create FutureViewModel");
    return FutureViewModel();
  }

  int counter = 1;
  add() {
    counter++;
    print("Add FutureViewModel " + counter.toString());
  }

  subtract() {
    counter--;
    print("Subtract FutureViewModel " + counter.toString());
  }
}
