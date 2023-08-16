import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_example/home_page.dart';
import 'package:get_it_example/view_model.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerFactory<RedViewModel>(() => RedViewModel()..add(),
      instanceName: "1 RedViewModel"); // init only when used and close if used again init
  getIt.registerSingleton<YellowViewModel>(
    YellowViewModel()..subtract(),
  ); // init at the same time and store
  getIt.registerLazySingleton<GreenViewModel>(
      () => GreenViewModel()); // init only when used and store
  getIt.registerFactory<RedViewModel>(() => RedViewModel(), instanceName: "2 RedViewModel");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}
