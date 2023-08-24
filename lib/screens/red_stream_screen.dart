import 'package:flutter/material.dart';
import 'package:get_it_example/components/counter_widget.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/red_view_model_stream.dart';

class RedScreen extends StatelessWidget {
  const RedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RedViewModel redViewModel2 = getIt.get<RedViewModel>(instanceName: "2 RedViewModel");
    RedViewModel redViewModel1 = getIt.get<RedViewModel>(instanceName: "1 RedViewModel");

    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.red,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Red Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                    "Is it example detail object model view because we used registerFactory. You have to pass a factory function func that returns a NEW instance of an implementation of T. Each time you call get<T>() you will get a new instance returned. How to pass parameters to a factory you can find here."),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CounterStream(
                    stream: redViewModel2.state,
                    title: "Example of usual Stream",
                    add: () => redViewModel2.add(),
                    subtract: () => redViewModel2.subtract(),
                  ),
                  SizedBox(
                    width: 400,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CounterStream(
                          stream: redViewModel1.state,
                          title: "Example of broadcast Stream 1",
                          add: () => redViewModel1.add(),
                          subtract: () => redViewModel1.subtract(),
                        ),
                        CounterStream(
                          stream: redViewModel1.state,
                          title: "Example of broadcast Stream 2",
                          add: () => redViewModel1.add(),
                          subtract: () => redViewModel1.subtract(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                child: const Text(" Stream Controller"),
                onPressed: () {
                  redViewModel1.streamController();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      TextButton(
                        child: const Text("Subscribe to Stream Counter"),
                        onPressed: () {
                          redViewModel1.subscriber(redViewModel1.counter);
                        },
                      ),
                      TextButton(
                        child: const Text("Async subscribe to Stream Counter"),
                        onPressed: () {
                          redViewModel1.asyncSubscribe();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        child: const Text("Subscribe to Stream with for in Counter"),
                        onPressed: () {
                          redViewModel1.forInWithCounter();
                        },
                      ),
                      TextButton(
                        child: const Text("Subscribe to Stream with for in 2 Counter"),
                        onPressed: () {
                          redViewModel1.forIn2WithCounter();
                        },
                      ),
                    ],
                  ),
                ],
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
