import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/layout/adaptative_input.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';

class RoundForm extends StatefulWidget {
  final void Function(Round round) onSubmit;
  const RoundForm(this.onSubmit, {super.key});

  @override
  State<RoundForm> createState() => _RoundForm();
}

class _RoundForm extends State<RoundForm> {
  _RoundForm();
  final _nomeController = TextEditingController();
  final _tempoController = TextEditingController();
  bool som = false;

  void _changeSom(bool? value) {
    if (value == null) {
      som = false;
      return;
    }
    som = value;
  }

  _submitForm() {
    final nome = _nomeController.text;
    final tempo = int.tryParse(_tempoController.text) ?? 0;

    if (nome.isEmpty || tempo <= 0) {
      return;
    }

    Round round = Round.basico(nome: nome, tempo: tempo, som: som);

    widget.onSubmit(round);
  }

  @override
  Widget build(BuildContext context) {
    final form = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Criar novo Round",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Text("Nome"),
          TextFormField(),
          AdaptativeInputText(label: "", controller: _nomeController),
          const Text("Tempo"),
          TextFormField(),
          const Text("som"),
          Checkbox(
            value: false,
            onChanged: _changeSom,
          )
        ],
      ),
    );

    return SizedBox(child: form);
  }
}
