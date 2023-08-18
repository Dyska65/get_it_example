import 'package:flutter/material.dart';
import 'package:get_it_example/components/add_subtract_buttons.dart';
import 'package:get_it_example/locator/locator.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/scope_view_model.dart';
import 'package:get_it_example/viewModels/abstract_view_models.dart';

class ScopeScreen extends StatefulWidget {
  const ScopeScreen({super.key});

  @override
  State<ScopeScreen> createState() => _ScopeScreenState();
}

class _ScopeScreenState extends State<ScopeScreen> {
  @override
  void initState() {
    ServiceLocator.setupScope("1 Scope");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AbstractViewModel pinkColorViewModel = getIt.get<PinkColorViewModelImpl>();
    AbstractViewModel brownColorViewModelImpl = getIt.get<BrownColorViewModelImpl>();

    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          actions: [
            TextButton(
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Work with Scope'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorContainer(Colors.pink, "pinkColorViewModel", pinkColorViewModel),
                    _buildColorContainer(
                        Colors.brown, "brownColorViewModelImpl", brownColorViewModelImpl),
                  ],
                ),
                TextButton(
                  child: const Text(
                    "Call onChanged",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    getIt.onScopeChanged!.call(true);
                  },
                ),
                _buildContainerNewScope(),
              ]),
        ));
  }

  _buildColorContainer(Color color, String nameViewModel, AbstractViewModel viewModel) {
    return Container(
      color: color,
      width: 200,
      height: 100,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(nameViewModel),
            Text(viewModel.counter.toString()),
            AddSubtractButtons(
                subtract: () => setState(() => viewModel.subtract()),
                add: () => setState(() => viewModel.add())),
          ]),
    );
  }

  _buildContainerNewScope() {
    ScopeAndRxDartViewModel scopeViewModel = getIt.get<ScopeAndRxDartViewModel>();
    return Container(
      height: 300,
      width: 300,
      color: Colors.white,
      child: StreamBuilder<String>(
          stream: scopeViewModel.currentScope,
          builder: (context, snapshot) {
            String currentScope = snapshot.data.toString();
            return Column(
              children: [
                TextButton(
                  child: Text(
                    currentScope == "Scope 2" ? "Close Scope" : "Create new Scope",
                    style: const TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (getIt.currentScopeName != "Scope 2") {
                      // await ServiceLocator.popScope();
                      getIt.pushNewScope(
                        scopeName: "Scope 2",
                        dispose: () => print("Dispose Scope 2"),
                      );
                    } else {
                      await ServiceLocator.dropScope("Scope 2");
                    }
                  },
                ),
                Text("Current Scope: " + currentScope),
                const SizedBox(height: 50),
                TextButton(
                  child: const Text(
                    "Create new async Scope",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (getIt.currentScopeName != "Scope 3 Async") {
                      getIt.pushNewScopeAsync(
                        init: (getIt) async {
                          await Future.delayed(const Duration(seconds: 3));
                        },
                        scopeName: "Scope 3 Async",
                        dispose: () => print("Dispose Scope 3 Async"),
                      );
                    } else {
                      await ServiceLocator.dropScope("Scope 3 Async");
                    }
                  },
                ),
                // if(currentScope=="Scope 3 Async")
                // FutureBuilder<>(
                //   future: ,
                //   builder: (BuildContext, AsyncSnapshot<dynamic> snapshot){}),
              ],
            );
          }),
    );
  }
}
