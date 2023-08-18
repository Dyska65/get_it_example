import 'package:flutter/material.dart';

class AddSubtractButtons extends StatelessWidget {
  final Function subtract;
  final Function add;
  const AddSubtractButtons({super.key, required this.subtract, required this.add});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: () => add(), icon: const Icon(Icons.add)),
        IconButton(onPressed: () => subtract(), icon: const Icon(Icons.remove))
      ],
    );
  }
}
