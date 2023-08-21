import 'dart:async';

class RedViewModel {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>.broadcast();

  Stream<int> get state => _streamController.stream;

  add() {
    _streamController.add(_counter++);
  }

  subtract() {
    _streamController.add(_counter--);
  }
}

class YellowViewModel {
  YellowViewModel() {}
  int counter = 1;
  add() {
    counter++;
  }

  subtract() {
    counter--;
  }
}

class GreenViewModel {
  GreenViewModel() {}
  int counter = 1;
  add() {
    counter++;
  }

  subtract() {
    counter--;
  }
}
