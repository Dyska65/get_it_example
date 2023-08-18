import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_example/screens/home_page.dart';
import 'package:get_it_example/locator/locator.dart';

GetIt getIt = GetIt.instance;

// If used instanceName you can call this viewModel only by instanceName
void main() async {
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
