import 'package:cristimer/view/components/seleciona_som.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/util/mask.dart';
import 'package:cristimer/core/util/tempoutil.dart';

class ExercicioForm extends StatefulWidget {
  final void Function(Exercicio exercicio) onSubmit;
  final Exercicio? exercicio;
  final bool pausa;
  const ExercicioForm(this.onSubmit, this.exercicio,
      {super.key, this.pausa = false});
  const ExercicioForm.pausa(this.onSubmit,
      {super.key, this.exercicio, this.pausa = true});

  @override
  State<ExercicioForm> createState() => _ExercicioForm();
}

class _ExercicioForm extends State<ExercicioForm> {
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
    // print(widget.round?.somInicio);
    _nomeController.text = widget.exercicio?.nome ?? "";
    _tempoController.text = TempoUtil.format(widget.exercicio?.tempo ?? 0);
    _delayController.text =
        TempoUtil.format(widget.exercicio?.delayTermino ?? 0);
    _descricaoController.text = widget.exercicio?.descricao ?? "";
    _somInicioController.text = widget.exercicio?.somInicio ?? "";
    _somPreTerminoController.text = widget.exercicio?.somPreTermino ?? "";
    _somTerminoController.text = widget.exercicio?.somTermino ?? "";

    id = widget.exercicio?.id ?? 0;
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
      Exercicio exercicio = Exercicio.basico(
        nome: "Pausa",
        descricao: "Pausa",
        tempo: tempo,
      );

      widget.onSubmit(exercicio);

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

    Exercicio exercicio = Exercicio.basico(
      nome: nome,
      descricao: descricao,
      tempo: tempo,
      somInicio: somInicio,
      somPreTermino: somPreTermino,
      somTermino: somTermino,
      delayTermino: delay,
    );

    if (id != 0) {
      exercicio.id = id;
      exercicio.ordem = widget.exercicio?.ordem ?? 0;
    }
    widget.onSubmit(exercicio);
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
            maxLength: 40,
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
          widget.pausa ? "Criar Pausa" : "Criar Exercicio",
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
