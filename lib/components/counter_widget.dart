import 'package:flutter/material.dart';
import 'package:get_it_example/components/add_subtract_buttons.dart';

class CounterStream extends StatelessWidget {
  final Stream<int>? stream;
  final String title;
  final Function subtract;
  final Function add;
  const CounterStream(
      {required this.stream,
      required this.title,
      required this.subtract,
      required this.add,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(title),
        StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              int? counter = snapshot.data;
              return Text(
                  "RedViewModel2 counter ${snapshot.data != null ? counter.toString() : ''}");
            }),
        AddSubtractButtons(
          add: () => add(),
          subtract: () => subtract(),
        ),
      ]),
    );
  }
}
