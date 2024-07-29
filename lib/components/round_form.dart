import 'package:flutter/material.dart';

class RoundForm extends StatelessWidget {
  const RoundForm({super.key});

  @override
  Widget build(BuildContext context) {
    final form = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            foregroundDecoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(
              "Criar novo Round",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text("Nome"),
          TextFormField(),
          Text("Tempo"),
          TextFormField(),
          Text("som"),
          Checkbox(
            value: false,
            onChanged: (a) {},
          )
        ],
      ),
    );

    return SizedBox(child: form);
  }
}
