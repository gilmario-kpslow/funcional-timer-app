import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _delayController = TextEditingController();
  bool somInicio = false;
  bool somTermino = false;

  void _changeSom(bool? value) {
    if (value == null) {
      return;
    }

    setState(() {
      somInicio = value;
    });
  }

  void _changeSomTermino(bool? value) {
    if (value == null) {
      return;
    }

    setState(() {
      somTermino = value;
    });
  }

  _submitForm() {
    final nome = _nomeController.text;
    final tempo = int.tryParse(_tempoController.text) ?? 0;
    final delay = int.tryParse(_delayController.text) ?? 0;

    if (nome.isEmpty || tempo <= 0) {
      return;
    }

    Round round = Round.basico(
        nome: nome,
        tempo: tempo,
        somInicio: somInicio,
        delayTermino: delay,
        somTermino: somTermino);

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
          decoration: InputDecoration(labelText: "Tempo"),
          keyboardType: TextInputType.number,
          inputFormatters: [
            TextInputFormatter.withFunction(
              (oldValue, newValue) {
                print("${oldValue.text} asdasdasdasdasd");
                print("${newValue.text} asdasdasdasdasd");

                return TextEditingValue(text: "exemplo");
              },
            )
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: somInicio,
              onChanged: _changeSom,
            ),
            const Text("Tocam som no início"),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: somTermino,
              onChanged: _changeSomTermino,
            ),
            const Text("Tocar Som ao término"),
          ],
        ),
        somTermino
            ? TextField(
                controller: _delayController,
                decoration:
                    const InputDecoration(labelText: "Delay termino (s)"),
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(3)],
              )
            : Container()
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
