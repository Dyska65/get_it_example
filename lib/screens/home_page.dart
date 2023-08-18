import 'package:flutter/material.dart';
import 'package:get_it_example/screens/color_screens.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/screens/scope_screen.dart';
import 'package:get_it_example/screens/future_screen.dart';
import 'package:get_it_example/viewModels/abstract_view_models.dart';
import 'package:get_it_example/viewModels/future_view_model.dart';
import 'package:get_it_example/viewModels/view_models.dart';

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
                  }),
              _buildWidgetLoadingViewModel(
                  () => getIt.isReady<FutureViewModel>(), "FutureViewModel"),
              buildColorItem(
                  name: "ViewModel register from interface",
                  isRegisteredViewModel: getIt.isRegistered<AbstractViewModel>(),
                  nextPage: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const ScopeScreen(),
                        ),
                      ),
                  onRegistering: () async {
                    getIt.isRegistered<AbstractViewModel>()
                        ? await getIt.unregister<AbstractViewModel>()
                        : getIt.registerSingleton<AbstractViewModel>(PinkColorViewModelImpl());

                    setState(() {});
                  }),
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
                _buildWidgetLoadingViewModel(
                    () => Future.value(getIt.isReadySync<YellowViewModel>()), "YellowViewModel"),
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

_buildWidgetLoadingViewModel(Future<void> Function() isReady, String nameViewModel) {
  return FutureBuilder(
      future: isReady(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Center(child: Text("$nameViewModel is Ready"));
        }
        return const CircularProgressIndicator(
          color: Colors.blue,
        );
      });
}