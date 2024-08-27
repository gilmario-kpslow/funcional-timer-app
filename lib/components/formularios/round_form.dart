import 'package:flutter/material.dart';
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
      return;
    }

    setState(() {
      som = value;
    });
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
    final form = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _nomeController,
          decoration: const InputDecoration(labelText: "Nome"),
        ),
        TextField(
          controller: _tempoController,
          decoration: const InputDecoration(labelText: "Tempo"),
          // keyboardAppearance: KeyboardKey.,
          keyboardType: const TextInputType.numberWithOptions(
              signed: false, decimal: false),
        ),
        const Text("som"),
        Checkbox(
          value: som,
          onChanged: _changeSom,
        )
      ],
    );

    return AlertDialog(
      scrollable: true,
      title: Container(
        alignment: Alignment.center,
        child: const Text(
          "Criar Round",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      content: form,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => _submitForm(),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
