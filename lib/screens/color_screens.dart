import 'package:flutter/material.dart';
import 'package:get_it_example/components/add_subtract_buttons.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/view_models.dart';

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
