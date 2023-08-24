import 'package:flutter/material.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/viewModels/view_models.dart';

class YellowScreen extends StatelessWidget {
  const YellowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    YellowViewModel yellowViewModel = getIt<YellowViewModel>()..subscribe();
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.yellow,
                padding: const EdgeInsets.all(10),
                child: Text("Yellow Screen"),
              ),
              const Text('registerSingleton is initialized on call and save'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    _buildContainer(
                      title: "TimerStream",
                      stream: StreamBuilder<String>(
                          stream: yellowViewModel.timerStream,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data);
                            }
                            return const CircularProgressIndicator(
                              color: Colors.blue,
                            );
                          }),
                    ),
                    _buildContainer(
                      title: "Merge Stream",
                      stream: StreamBuilder<String>(
                          stream: yellowViewModel.mergeStream,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data);
                            }
                            return const CircularProgressIndicator(
                              color: Colors.blue,
                            );
                          }),
                    ),
                    _buildContainer(
                      title: "Autocomplete with bounced",
                      stream: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 50,
                            child: TextFormField(
                              onChanged: (value) {
                                yellowViewModel.changedSubjectTextFormField(value);
                              },
                            ),
                          ),
                          StreamBuilder<String>(
                              stream: yellowViewModel.subscribeAutocomplete,
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                return Text(snapshot.data ?? "");
                              }),
                        ],
                      ),
                    ),
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildContainer(
                        title: "Stream with Map and Where",
                        stream: TextButton(
                          child: const Text("Watch console"),
                          onPressed: () {
                            yellowViewModel.streamWithMapAndWhere();
                          },
                        ),
                      ),
                      _buildContainer(
                        title: "Stream with Expand",
                        stream: TextButton(
                          child: const Text("Watch console"),
                          onPressed: () {
                            yellowViewModel.streamWithExpand();
                          },
                        ),
                      ),
                      _buildContainer(
                        title: "Stream with Merge",
                        stream: TextButton(
                          child: const Text("Watch console"),
                          onPressed: () {
                            yellowViewModel.streamWithMerge();
                          },
                        ),
                      ),
                      _buildContainer(
                        title: "Stream with Zip",
                        stream: TextButton(
                          child: const Text("Watch console"),
                          onPressed: () {
                            yellowViewModel.streamWithZip();
                          },
                        ),
                      ),
                      _buildContainer(
                        title: "Stream with ConcatWith",
                        stream: TextButton(
                          child: const Text("Watch console"),
                          onPressed: () {
                            yellowViewModel.streamWithConcatWith();
                          },
                        ),
                      ),
                      _buildContainer(
                        title: "Stream with CombineLatestStream",
                        stream: TextButton(
                          child: const Text("Watch console"),
                          onPressed: () {
                            yellowViewModel.streamWithCombineLatest();
                          },
                        ),
                      ),
                    ],
                  )
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

  Widget _buildContainer({required String title, required Widget stream}) {
    return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title), stream]));
  }
}
