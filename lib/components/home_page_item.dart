import 'package:flutter/material.dart';

class HomePageItem extends StatelessWidget {
  final String name;
  final bool isRegisteredViewModel;
  final Function() moveToPage;
  const HomePageItem(
      {required this.name,
      required this.isRegisteredViewModel,
      required this.moveToPage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Text("isRegistered $name ${isRegisteredViewModel.toString()}"),
          TextButton(
            child: Text("Move to $name screen"),
            onPressed: () {
              moveToPage();
            },
          ),
        ],
      ),
    );
  }
}
