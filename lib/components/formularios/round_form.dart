import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funcional_timer_app/core/modelos/round.dart';
import 'package:funcional_timer_app/core/util/mask.dart';

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
  final _descricaoController = TextEditingController();
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
    final descricao = _descricaoController.text;
    final tempo =
        int.tryParse(_tempoController.text.replaceFirst(":", "")) ?? 0;
    final delay =
        int.tryParse(_delayController.text.replaceFirst(":", "")) ?? 0;

    if (nome.isEmpty || tempo <= 0) {
      return;
    }

    Round round = Round.basico(
        nome: nome,
        descricao: descricao,
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
          controller: _descricaoController,
          decoration: const InputDecoration(labelText: "Descrição"),
          maxLines: 2,
        ),
        TextField(
          controller: _tempoController,
          decoration: const InputDecoration(labelText: "Tempo"),
          keyboardType: TextInputType.number,
          inputFormatters: [
            TextInputFormatter.withFunction(
              (oldValue, newValue) {
                return TextEditingValue(
                  text: maskTime(newValue.text),
                );
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
                inputFormatters: [
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                      return TextEditingValue(
                        text: maskTime(newValue.text),
                      );
                    },
                  )
                ],
              )
            : Container()
      ],
    );

    return AlertDialog(
      scrollable: true,
      title: Container(
        width: 350,
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
