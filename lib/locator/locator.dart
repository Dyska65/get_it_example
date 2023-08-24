import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/abstract_view_models.dart';
import 'package:get_it_example/viewModels/future_view_model.dart';
import 'package:get_it_example/viewModels/red_view_model_stream.dart';
import 'package:get_it_example/viewModels/scope_view_model.dart';
import 'package:get_it_example/viewModels/view_models.dart';

class ServiceLocator {
  static initLocator() {
    getIt.registerFactory<RedViewModel>(() => RedViewModel(),
        instanceName: "1 RedViewModel"); // init only when used and close if used again init
    getIt.registerSingleton<YellowViewModel>(YellowViewModel(), signalsReady: true,
        dispose: ((param) {
      print("Dispose YellowViewModel");
    })); // init at the same time and store
    getIt.registerLazySingleton<GreenViewModel>(
      () => GreenViewModel(),
      dispose: ((param) {
        print("Dispose GreenViewModel");
      }),
    ); // init only when used and store
    getIt.registerFactory<RedViewModel>(() => RedViewModel(), instanceName: "2 RedViewModel");
    getIt.registerSingletonAsync<FutureViewModel>(() => FutureViewModel.createFutureViewModel());
    getIt.registerSingleton<AbstractViewModel>(
      PinkColorViewModelImpl(),
      instanceName: "2",
    ); // example used interface https://vc.ru/s/2091385-devblog-razrabotka-na-flutter/758796-getit-prostoy-i-udobnyy-servis-lokator

    getIt.registerSingleton<AbstractViewModel>(
      PinkColorViewModelImpl(),
      instanceName: "3",
    ); // example used interface https://vc.ru/s/2091385-devblog-razrabotka-na-flutter/758796-getit-prostoy-i-udobnyy-servis-lokator
    getIt.get<AbstractViewModel>(instanceName: "3");
    getIt.registerSingleton<ScopeAndRxDartViewModel>(ScopeAndRxDartViewModel()..listenScopes());
  }

  static setupScope(String nameScope) {
    if (getIt.currentScopeName != nameScope) {
      getIt.registerSingleton<PinkColorViewModelImpl>(PinkColorViewModelImpl(counter: -5));
      getIt.pushNewScope(
        scopeName: nameScope,
        dispose: () => print("Dispose " + nameScope),
      );

      getIt.registerSingleton<BrownColorViewModelImpl>(BrownColorViewModelImpl());
      getIt.registerSingleton<PinkColorViewModelImpl>(PinkColorViewModelImpl(counter: -2));
    }
  }

  static resetScope() async {
    if (getIt.currentScopeName == 'baseScope') {
      return;
    }
    await getIt.resetScope(); // only for current scope
  }

  static dropScope(String scopeName) async {
    await getIt.dropScope(scopeName); // by nameScope
  }

  static popScope() async {
    if (getIt.currentScopeName == 'baseScope') {
      return;
    }
    await getIt.popScope();
  }
}
