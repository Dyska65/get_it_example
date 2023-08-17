import 'package:get_it_example/main.dart';
import 'package:get_it_example/view_model.dart';

class ServiceLocator {
  static initLocator() {
    getIt.registerFactory<RedViewModel>(() => RedViewModel()..add(),
        instanceName: "1 RedViewModel"); // init only when used and close if used again init
    getIt.registerSingleton<YellowViewModel>(YellowViewModel()..subtract(), signalsReady: true,
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
    getIt.registerSingleton<ColorViewModel>(
        PinkColorViewModel()); // example used interface https://vc.ru/s/2091385-devblog-razrabotka-na-flutter/758796-getit-prostoy-i-udobnyy-servis-lokator
  }
}
