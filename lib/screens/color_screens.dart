import 'package:flutter/material.dart';
import 'package:get_it_example/components/add_subtract_buttons.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/view_models.dart';

class RedScreen extends StatelessWidget {
  const RedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RedViewModel redViewModel2 = getIt.get<RedViewModel>(instanceName: "2 RedViewModel");
    RedViewModel redViewModel1 = getIt.get<RedViewModel>(instanceName: "1 RedViewModel");

    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Red Screen"),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "Is it example detail object model view because we used registerFactory. You have to pass a factory function func that returns a NEW instance of an implementation of T. Each time you call get<T>() you will get a new instance returned. How to pass parameters to a factory you can find here."),
              ),
              Text("RedViewModel1 counter ${redViewModel1.counter.toString()}"),
              AddSubtractButtons(
                add: () => redViewModel1.add(),
                subtract: () => redViewModel1.subtract(),
              ),
              Text("RedViewModel2 counter ${redViewModel1.counter.toString()}"),
              AddSubtractButtons(
                add: () => redViewModel2.add(),
                subtract: () => redViewModel2.subtract(),
              ),
              TextButton(
                child: const Text("Back"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}

class YellowScreen extends StatelessWidget {
  const YellowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    YellowViewModel yellowViewModel = getIt<YellowViewModel>();

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Yellow Screen"),
              const Text('registerSingleton is initialized on call and save'),
              Text("YellowViewModel counter ${yellowViewModel.counter.toString()}"),
              AddSubtractButtons(
                add: () => yellowViewModel.add(),
                subtract: () => yellowViewModel.subtract(),
              ),
              TextButton(
                child: const Text("Back"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}

class GreenScreen extends StatelessWidget {
  const GreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GreenViewModel greenViewModel = getIt<GreenViewModel>();

    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Green Screen"),
              const Text('registerSingleton is initialized on use and saved'),
              Text("GreenViewModel counter ${greenViewModel.counter.toString()}"),
              AddSubtractButtons(
                add: () => greenViewModel.add(),
                subtract: () => greenViewModel.subtract(),
              ),
              TextButton(
                child: const Text("Back"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}
