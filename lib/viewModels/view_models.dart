import 'dart:async';
import 'package:rxdart/rxdart.dart';

class YellowViewModel {
  // Subject = StreamController
  var subjectTextFormField = PublishSubject<String>();
  late Stream<String> subscribeAutocomplete;

  var timerStream =
      TimerStream<String>("Value from TimerStream", Duration(seconds: 5)).asBroadcastStream();
  var mergeStream = MergeStream<String>([
    TimerStream("Value from 1 Stream", Duration(seconds: 5)),
    Stream.value("Value from 2 Stream")
  ]);

  retryStream() {
    RetryStream(
      () => Stream.fromFuture(futureFunc()),
      1,
    )..listen(
        (i) => print(i.toString()),
        onError: (Object e, StackTrace s) => print(e), // work onle after complete
        onDone: () => print("Finish"),
      );
  }

  Future futureFunc() async {
    print("Start futureFunc");
    await Future.delayed(Duration(seconds: 2));
    print("init error");

    return await Future.error("error from futureFunc");
    // return true;
  }

  subscribe() {
    subscribeAutocomplete = subjectTextFormField
        .debounce((_) => TimerStream(true, Duration(seconds: 1)))
      ..asBroadcastStream();
  }

  changedSubjectTextFormField(String text) {
    subjectTextFormField.add(text);
  }

  streamWithMapAndWhere() {
    // Map andWhere work only for listen behind
    var _streamController = BehaviorSubject<String>()..asBroadcastStream();
    _streamController
        .map((event) =>
            // Here usual used Object.fromMap()
            event + " After Map")
        .listen((event) {
      print("Result after Map " + event);
    });
    _streamController.where((event) => event.contains("1")).listen((event) {
      print("Result after Where " + event);
    });
    StreamSubscription _subscription = _streamController.listen((event) {
      print("StreamSubscription " + event);
    });
    _streamController.add(" Value 1");
    _streamController.add(" Value 2");

    Future.delayed(Duration(seconds: 5), () {
      _subscription.cancel();
      _streamController.close();
    });
  }

  streamWithExpand() {
    // Expand andWhere work only for listen behind

    List<int> list = [1, 2, 3, 4, 5];
    var _streamController = ReplaySubject<List>(maxSize: 2)..asBroadcastStream();

    _streamController.add(list);
    _streamController.add(list);
    _streamController.add(list);

    StreamSubscription _subscription =
        _streamController.expand((element) => element).listen((event) {
      print("StreamSubscription " + event.toString());
    });
    Future.delayed(Duration(seconds: 5), () {
      _subscription.cancel();
      _streamController.close();
    });
  }

  streamWithMerge() {
    // Returns value as soon as received
    var _streamController1 = PublishSubject<int>()..asBroadcastStream();
    var _streamController2 = PublishSubject<int>()..asBroadcastStream();
    var _streamController3 = PublishSubject<int>()..asBroadcastStream();

    StreamSubscription _subscription = _streamController1
        .mergeWith([_streamController2.stream, _streamController3.stream]).listen((event) {
      print("StreamSubscription mergeWith: " + event.toString());
    });
    Future.delayed(Duration(seconds: 1), () => _streamController1.add(1));
    Future.delayed(Duration(seconds: 2), () => _streamController2.add(2));
    Future.delayed(Duration(seconds: 3), () => _streamController3.add(3));
  }

  streamWithZip() {
    // Returns value after receive all
    var _streamController1 = PublishSubject<int>()..asBroadcastStream();
    var _streamController2 = PublishSubject<int>()..asBroadcastStream();

    _streamController1.zipWith(_streamController2, (one, two) => one + two).listen((event) {
      print("StreamSubscription zipWith: " + event.toString());
    });
    _streamController1.listen((event) {
      print("StreamSubscription1 : " + event.toString());
    });
    _streamController2.listen((event) {
      print("StreamSubscription2 : " + event.toString());
    });
    Future.delayed(Duration(seconds: 1), () => _streamController1.add(1));
    Future.delayed(Duration(seconds: 2), () => _streamController1.add(2));

    Future.delayed(Duration(seconds: 3), () => _streamController2.add(2));
    Future.delayed(Duration(seconds: 4), () => _streamController2.add(3));
  }

  streamWithConcatWith() {
    // Returns value from first Stream after this stream close() return value from 2 stream and so on
    var _streamController1 = PublishSubject<int>()..asBroadcastStream();
    var _streamController2 = PublishSubject<int>()..asBroadcastStream();
    StreamSubscription _subscription =
        _streamController1.concatWith([_streamController2]).listen((event) {
      print("StreamSubscription concatWith: " + event.toString());
    });
    Future.delayed(Duration(seconds: 1), () => _streamController1.add(1));
    Future.delayed(Duration(seconds: 2), () => _streamController2.add(4)); // This value dont listen
    Future.delayed(Duration(seconds: 3), () => _streamController1.add(2));

    Future.delayed(Duration(seconds: 4), () => _streamController1.close());

    Future.delayed(Duration(seconds: 5), () => _streamController2.add(3));
  }

  streamWithCombineLatest() {
    var _streamController1 = PublishSubject<int>()..asBroadcastStream();
    var _streamController2 = PublishSubject<int>()..asBroadcastStream();
    var combineLatestStream =
        CombineLatestStream([_streamController1, _streamController2], (values) => values)
            .listen((event) {
      print("StreamSubscription combineLatestStream: " + event.toString());
    });
    _streamController1.listen((event) {
      print("StreamSubscription1 : " + event.toString());
    });
    _streamController2.listen((event) {
      print("StreamSubscription2 : " + event.toString());
    });
    Future.delayed(Duration(seconds: 1), () => _streamController1.add(1));
    Future.delayed(Duration(seconds: 2), () => _streamController1.add(2));

    Future.delayed(Duration(seconds: 3), () => _streamController2.add(2));
    Future.delayed(Duration(seconds: 4), () => _streamController2.add(3));
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
