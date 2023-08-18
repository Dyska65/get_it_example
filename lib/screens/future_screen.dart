import 'package:flutter/material.dart';
import 'package:get_it_example/components/add_subtract_buttons.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/future_view_model.dart';

class FutureScreen extends StatelessWidget {
  const FutureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: FutureBuilder<FutureViewModel>(
            future: getIt.getAsync<FutureViewModel>(),
            builder: (context, AsyncSnapshot<FutureViewModel> snapshot) {
              if (snapshot.hasData) {
                FutureViewModel futureViewModel = snapshot.data!;

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("FutureScreen"),
                      const Text('registerFactoryAsync is initialized on use and close'),
                      Text("Future ViewModel counter ${futureViewModel.counter.toString()}"),
                      AddSubtractButtons(
                        add: () => futureViewModel.add(),
                        subtract: () => futureViewModel.subtract(),
                      ),
                      TextButton(
                        child: const Text("Back"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]);
              }
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }),
      ),
    );
  }
}
