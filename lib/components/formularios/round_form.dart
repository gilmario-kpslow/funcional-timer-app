import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cristimer/core/modelos/round.dart';
import 'package:cristimer/core/util/mask.dart';
import 'package:cristimer/core/util/tempoutil.dart';

class RoundForm extends StatefulWidget {
  final void Function(Round round) onSubmit;
  final Round? round;
  const RoundForm(this.onSubmit, this.round, {super.key});

  @override
  State<RoundForm> createState() => _RoundForm();
}

class _RoundForm extends State<RoundForm> {
  final _nomeController = TextEditingController();
  final _tempoController = TextEditingController();
  final _delayController = TextEditingController();
  final _descricaoController = TextEditingController();
  bool somInicio = false;
  bool somTermino = false;
  int id = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _changeSom(bool? value) {
    if (value == null) {
      return;
    }

    setState(() {
      somInicio = value;
    });
  }

  _init() {
    _nomeController.text = widget.round?.nome ?? "";
    _tempoController.text = TempoUtil.format(widget.round?.tempo ?? 0);
    _delayController.text = TempoUtil.format(widget.round?.delayTermino ?? 0);
    _descricaoController.text = widget.round?.descricao ?? "";
    somInicio = widget.round?.somInicio ?? false;
    somTermino = widget.round?.somTermino ?? false;
    id = widget.round?.id ?? 0;
  }

  void _changeSomTermino(bool? value) {
    if (value == null) {
      return;
    }

    setState(() {
      somTermino = value;
    });
  }

  final _formKey = GlobalKey<FormState>();

  String? _defaultValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nome = _nomeController.text;
    final descricao = _descricaoController.text;
    final tempo = TempoUtil.parse(_tempoController.text);
    final delay = TempoUtil.parse(_delayController.text);

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

    if (id != 0) {
      round.id = id;
      round.ordem = widget.round?.ordem;
    }

    widget.onSubmit(round);
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(labelText: "Nome"),
            validator: _defaultValidate,
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: "Descrição"),
            validator: _defaultValidate,
            maxLines: 2,
          ),
          TextFormField(
            controller: _tempoController,
            decoration: const InputDecoration(labelText: "Tempo"),
            keyboardType: TextInputType.number,
            validator: _defaultValidate,
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
              ? TextFormField(
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
      ),
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
