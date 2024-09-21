import 'package:cristimer/components/layout/seleciona_som.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cristimer/core/modelos/round.dart';
import 'package:cristimer/core/util/mask.dart';
import 'package:cristimer/core/util/tempoutil.dart';

class RoundForm extends StatefulWidget {
  final void Function(Round round) onSubmit;
  final Round? round;
  final bool pausa;
  const RoundForm(this.onSubmit, this.round, {super.key, this.pausa = false});
  const RoundForm.pausa(this.onSubmit,
      {super.key, this.round, this.pausa = true});

  @override
  State<RoundForm> createState() => _RoundForm();
}

class _RoundForm extends State<RoundForm> {
  final _nomeController = TextEditingController();
  final _tempoController = TextEditingController();
  final _delayController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _somInicioController = TextEditingController();
  final _somPreTerminoController = TextEditingController();
  final _somTerminoController = TextEditingController();

  int id = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    print(widget.round?.somInicio);
    _nomeController.text = widget.round?.nome ?? "";
    _tempoController.text = TempoUtil.format(widget.round?.tempo ?? 0);
    _delayController.text = TempoUtil.format(widget.round?.delayTermino ?? 0);
    _descricaoController.text = widget.round?.descricao ?? "";
    _somInicioController.text = widget.round?.somInicio ?? "";
    _somPreTerminoController.text = widget.round?.somPreTermino ?? "";
    _somTerminoController.text = widget.round?.somTermino ?? "";

    id = widget.round?.id ?? 0;
  }

  final _formKey = GlobalKey<FormState>();

  String? _defaultValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  _submitForm() {
    if (widget.pausa) {
      final tempo = TempoUtil.parse(_tempoController.text);
      Round round = Round.basico(
        nome: "Pausa",
        descricao: "Pausa",
        tempo: tempo,
      );

      widget.onSubmit(round);

      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nome = _nomeController.text;
    final descricao = _descricaoController.text;
    final tempo = TempoUtil.parse(_tempoController.text);
    final delay = TempoUtil.parse(_delayController.text);
    final somInicio = _somInicioController.text;
    final somPreTermino = _somPreTerminoController.text;
    final somTermino = _somTerminoController.text;

    Round round = Round.basico(
      nome: nome,
      descricao: descricao,
      tempo: tempo,
      somInicio: somInicio,
      somPreTermino: somPreTermino,
      somTermino: somTermino,
      delayTermino: delay,
    );

    if (id != 0) {
      round.id = id;
      round.ordem = widget.round?.ordem ?? 0;
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
          TextFormField(
            controller: _delayController,
            decoration: const InputDecoration(labelText: "Delay termino (s)"),
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
          SelecionaSom(
            label: "Som inicio",
            controller: _somInicioController,
          ),
          SelecionaSom(
            label: "Som pre termino",
            controller: _somPreTerminoController,
          ),
          SelecionaSom(
            label: "Som termino",
            controller: _somTerminoController,
          ),
        ],
      ),
    );

    final formBasico = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );

    return AlertDialog(
      scrollable: true,
      title: Container(
        width: 350,
        alignment: Alignment.center,
        child: Text(
          widget.pausa ? "Criar Pausa" : "Criar Round",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      content: widget.pausa ? formBasico : form,
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
