import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_example/home_page.dart';
import 'package:get_it_example/locator/locator.dart';

GetIt getIt = GetIt.instance;

void main() {
  ServiceLocator.initLocator();
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
        home: const MyHomePage());
  }
}
