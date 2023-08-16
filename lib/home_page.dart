import 'package:flutter/material.dart';
import 'package:get_it_example/color_screen.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              buildColorItem(
                  name: "Future ModelView",
                  isRegisteredViewModel: getIt.isRegistered<FutureViewModel>(),
                  nextPage: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const FutureScreen(),
                        ),
                      ),
                  onRegistering: () async {
                    getIt.isRegistered<FutureViewModel>()
                        ? await getIt.unregister<FutureViewModel>()
                        : getIt.registerFactoryAsync<FutureViewModel>(
                            () => FutureViewModel.createFutureViewModel());

                    setState(() {});
                  })
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildColorItem(
                    name: "Yellow ",
                    isRegisteredViewModel: getIt.isRegistered<YellowViewModel>(),
                    nextPage: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const YellowScreen(),
                          ),
                        ),
                    onRegistering: () async {
                      getIt.isRegistered<YellowViewModel>()
                          ? await getIt.unregister<YellowViewModel>()
                          : getIt.registerSingleton<YellowViewModel>(YellowViewModel());

                      setState(() {});
                    }),
                buildColorItem(
                    name: "Red ",
                    isRegisteredViewModel: getIt.isRegistered<RedViewModel>(),
                    nextPage: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const RedScreen(),
                          ),
                        ),
                    onRegistering: () async {
                      getIt.isRegistered<RedViewModel>()
                          ? await getIt.unregister<RedViewModel>()
                          : getIt.registerSingleton<RedViewModel>(RedViewModel());

                      setState(() {});
                    }),
                buildColorItem(
                    name: "Green ",
                    isRegisteredViewModel: getIt.isRegistered<GreenViewModel>(),
                    nextPage: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const GreenScreen(),
                          ),
                        ),
                    onRegistering: () async {
                      getIt.isRegistered<GreenViewModel>()
                          ? await getIt.unregister<GreenViewModel>()
                          : getIt.registerSingleton<GreenViewModel>(GreenViewModel());

                      setState(() {});
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildColorItem({
  required String name,
  required bool isRegisteredViewModel,
  required Function() nextPage,
  required Function() onRegistering,
}) {
  return Column(
    children: [
      Text("isRegistered $name " + isRegisteredViewModel.toString()),
      TextButton(
        onPressed: () async {
          onRegistering();
        },
        child: Text(isRegisteredViewModel ? 'Unregistered $name' : 'Registered $name'),
      ),
      TextButton(
        child: Text("Move to $name screen"),
        onPressed: () {
          nextPage();
        },
      ),
    ],
  );
}
