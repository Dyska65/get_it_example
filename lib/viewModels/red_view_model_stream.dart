import 'dart:async';
import 'package:rxdart/rxdart.dart';

class RedViewModel {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>.broadcast();
  Stream<int> get state => _streamController.stream;

  Stream<int> get counter => Stream.periodic(Duration(seconds: 1), (counter) => counter);

  subscriber(Stream<int> stream) {
    StreamSubscription<int> subscriptionCounter = stream.listen((i) => print(i));
    Future.delayed(Duration(seconds: 5), () {
      subscriptionCounter.pause();
    });
    Future.delayed(Duration(seconds: 10), () {
      subscriptionCounter.resume();
    });
    Future.delayed(Duration(seconds: 15), () {
      subscriptionCounter.cancel();
    });
  }

  asyncSubscribe() async {
    StreamSubscription<int> subscriptionCounter = counter.listen((i) async {
      if (i.isOdd) {
        await Future.delayed(Duration(seconds: 3));
      }
      print(i);
    });
    Future.delayed(Duration(seconds: 15), () {
      subscriptionCounter.cancel();
    });
  }

  forInWithCounter() async {
    await forIn();
  }

  forIn2WithCounter() {
    forIn();
    forIn();
  }

  Future forIn() async {
    await for (var item in counter) {
      print(item);
    }
  }

  streamController() {
    print("One");
    StreamController<int> streamController = StreamController(
      onListen: () => print("Stream: Somebody listen to me"),
      onPause: () => print("Stream: Somebody stopped listening to me"),
      onResume: () => print("Stream: Somebody continue listening to me"),
      onCancel: () => print("Stream: Somebody cancel listening to me"),
      // sync: true,
      sync: false,
    );
    print("Two");
    subscriber(streamController.stream);

    // StreamSubscription<int> subscription = streamController.stream.listen((i) => print(i));
    streamController.add(1);
    streamController.add(2);
    streamController.add(3);
    print("Three");
  }

  add() {
    _streamController.add(_counter++);
  }

  subtract() {
    _streamController.add(_counter--);
  }
}
