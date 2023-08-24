import 'package:flutter/material.dart';
import 'package:get_it_example/components/home_page_item.dart';
import 'package:get_it_example/screens/color_screens.dart';
import 'package:get_it_example/main.dart';
import 'package:get_it_example/screens/red_stream_screen.dart';
import 'package:get_it_example/screens/scope_screen.dart';
import 'package:get_it_example/screens/future_screen.dart';
import 'package:get_it_example/screens/yellow_rxdart_screen.dart';
import 'package:get_it_example/viewModels/abstract_view_models.dart';
import 'package:get_it_example/viewModels/future_view_model.dart';
import 'package:get_it_example/viewModels/red_view_model_stream.dart';
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
              HomePageItem(
                name: "Future ModelView",
                isRegisteredViewModel: getIt.isRegistered<FutureViewModel>(),
                moveToPage: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const FutureScreen(),
                  ),
                ),
              ),
              _buildWidgetLoadingViewModel(
                  () => getIt.isReady<FutureViewModel>(), "FutureViewModel"),
              HomePageItem(
                name: "ViewModel register from interface",
                isRegisteredViewModel: getIt.isRegistered<AbstractViewModel>(),
                moveToPage: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ScopeScreen(),
                  ),
                ),
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HomePageItem(
                  name: "Yellow + RxDart",
                  isRegisteredViewModel: getIt.isRegistered<YellowViewModel>(),
                  moveToPage: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const YellowScreen(),
                    ),
                  ),
                ),
                _buildWidgetLoadingViewModel(
                  () => Future.value(getIt.isReadySync<YellowViewModel>()),
                  "YellowViewModel",
                ),
                HomePageItem(
                  name: "Simple Stream + Red ",
                  isRegisteredViewModel: getIt.isRegistered<RedViewModel>(),
                  moveToPage: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const RedScreen(),
                    ),
                  ),
                ),
                HomePageItem(
                  name: "Green ",
                  isRegisteredViewModel: getIt.isRegistered<GreenViewModel>(),
                  moveToPage: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const GreenScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
    },
  );
}
