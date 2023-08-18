abstract class AbstractViewModel {
  int counter = 1;
  add() {}
  subtract() {}
}

class PinkColorViewModelImpl implements AbstractViewModel {
  PinkColorViewModelImpl({this.counter = -1});

  @override
  int counter = -10;

  @override
  add() {
    counter++;
  }

  @override
  subtract() {
    counter--;
  }
}

class BrownColorViewModelImpl implements AbstractViewModel {
  @override
  int counter = -20;

  @override
  add() {
    counter++;
  }

  @override
  subtract() {
    counter--;
  }
}
