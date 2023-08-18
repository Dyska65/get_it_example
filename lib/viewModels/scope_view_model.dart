import 'package:get_it_example/main.dart';
import 'package:rxdart/rxdart.dart';

class ScopeAndRxDartViewModel {
  BehaviorSubject<String> currentScope = BehaviorSubject<String>();
  Stream<String> get currentScopeStream => currentScope.stream;

  listenScopes() {
    getIt.onScopeChanged = (pushed) {
      print("Listener Scope " +
          getIt.currentScopeName.toString() +
          " onScopeChanged " +
          pushed.toString());
      currentScope.add(getIt.currentScopeName.toString());
    };
  }
}
